
import Vapor

public struct Webhook: Content {
    
    public let url: String
    public let token: String?
    public let dropPending: Bool?
    
    public init(url: String, token: String? = nil, dropPending: Bool? = nil) {
        self.url = url
        self.token = token
        self.dropPending = dropPending
    }
}

extension Webhook {
    
    enum CodingKeys: String, CodingKey {
        case url
        case token = "secret_token"
        case dropPending = "drop_pending_updates"
    }
}
