
import Vapor

public struct User: Content {
    
    public let id: Int
    public let is_bot: Bool
    public let username: String?
}
