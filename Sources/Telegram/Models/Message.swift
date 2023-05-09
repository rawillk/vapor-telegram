
import Vapor

public struct Message: Content {
    
    public let messageId: Int64
    public let chat: Chat
    public let text: String?
    public let from: User?
    public let date: Date
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
    
    var command: Command? {
        guard let text else { return nil }
        let prefix = "/"
        guard text.hasPrefix(prefix) else { return nil }
        return .init(rawValue: text)
    }
}
