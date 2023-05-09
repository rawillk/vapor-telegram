
import Vapor

public struct User: Content {
    
    public let id: Int64
    public let isBot: Bool
    public let username: String?
}
