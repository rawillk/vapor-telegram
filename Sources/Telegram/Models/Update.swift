
import Vapor

public struct Update: Content {
    
    public let updateId: Int
    public let message: Message?
    public let callbackQuery: CallbackQuery?
}
