
import Vapor

public struct CallbackQuery: Content {
    
    public let id: Int64
    public let from: User
    public let message: Message?
    public let data: String?
}
