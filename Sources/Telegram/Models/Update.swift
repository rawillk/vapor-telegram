
import Vapor

public struct Update: Content {
    
    public let update_id: Int
    public let message: Message?
}
