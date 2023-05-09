
import Vapor

public struct User: Content {
    
    public let id: Int64
    public let is_bot: Bool
    public let username: String?
}
