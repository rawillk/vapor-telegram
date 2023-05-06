
import Vapor

public struct Message: Content {
    
    public let message_id: Int
    public let chat: Chat
    public let text: String?
    public let from: User?
}

public extension Message {
    
    struct Out: Content {
        
        public let chat_id: String
        public let text: String
        
        public init(chat_id: String, text: String) {
            self.chat_id = chat_id
            self.text = text
        }
    }
}
