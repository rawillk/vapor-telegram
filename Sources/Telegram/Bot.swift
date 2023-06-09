

import Vapor

public final class Bot {
    
    public let app: Application
    public var client: Client { app.client }
    public var logger: Logger { app.logger }
    public let decoder: JSONDecoder = .init()
    let api: API
    
    private var sessions: [any ChatSession] = []
    
    init(_ app: Application, api: API = API()) {
        self.app = app
        self.api = api
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
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
    
    public func answer(query: CallbackQuery.Answer, with text: String? = nil) async throws {
        let done: Bool = try unwrap(try await client.post(api.uri(.answerCallbackQuery), content: query ))
        if !done {
            throw Abort(.conflict, reason: "Server response not successfull")
        }
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
        if let data = response.body {
            let string = String(buffer: data)
            print(string)
        }
        let payload = try response.content.decode(API.Payload<R>.self, using: decoder)
        if payload.ok {
            logger.log(level: .info, "Telegram Bot: Content received")
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

