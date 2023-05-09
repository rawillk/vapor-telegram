

import Vapor

public final class Bot {
    
    public let app: Application
    public var client: Client { app.client }
    public var logger: Logger { app.logger }
    let api: API
    
    private var sessions: [any ChatSession] = []
    private let decoder: JSONDecoder = .init()
    
    init(_ app: Application, api: API = API()) {
        self.app = app
        self.api = api
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    @discardableResult
    public func register<S: ChatSession>(_ type: S.Type) -> S {
        let chat = S.init(bot: self)
        sessions.append(chat)
        return chat
    }
    
    public func getMe() async throws -> User {
        try unwrap(try await client.get(api.uri(.getMe)))
    }
    
    public func getUpdates() async throws -> [Update] {
        try unwrap(try await client.get(api.uri(.getUpdates)))
    }
    
    public func send(message: Message.Out) async throws -> Message {
        try unwrap(try await client.post(api.uri(.sendMessage), content: message))
    }
    
    public func set(webhook: Webhook) async throws {
        try unwrap(response: try await client.post(api.uri(.setWebhook), content: webhook))
    }
    
    public func deleteWebhook(dropPendingUpdates: Bool = false) async throws {
        struct Config: Content {
            let drop_pending_updates: Bool
        }
        return try unwrap(response: try await client.post(api.uri(.deleteWebhook), content: Config(drop_pending_updates: dropPendingUpdates)))
    }
    
    private func unwrap<R: Content>(_ response: ClientResponse) throws -> R {
        let payload = try response.content.decode(API.Payload<R>.self, using: decoder)
        if payload.ok {
            logger.log(level: .info, "Telegram Bot: Content received")
        }
        if let data = response.body {
            let string = String(buffer: data)
            print(string)
        }
        return payload.result
    }
    
    private func unwrap(response: ClientResponse) throws {
        let payload = try response.content.decode(API.EmptyPayload.self, using: decoder)
        if payload.ok {
            logger.log(level: .info, "Telegram Bot: Content received")
        }
    }
}

