

import Vapor

public final class Bot {
    
    let client: Client
    let logger: Logger
    let api: API
    
    private var sessions: [any ChatSession] = []
    
    init(client: Client, logger: Logger, api: API = API()) {
        self.client = client
        self.api = api
        self.logger = logger
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
        let payload = try response.content.decode(API.Payload<R>.self)
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
        let payload = try response.content.decode(API.EmptyPayload.self)
        if payload.ok {
            logger.log(level: .info, "Telegram Bot: Content received")
        }
    }
}

