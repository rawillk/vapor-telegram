
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
        public let text: String?
        public let reply_markup: InlineKeyboardMarkup?
        
        public init(chat_id: String, text: String?, keyboard: InlineKeyboardMarkup? = nil) {
            self.chat_id = chat_id
            self.text = text
            self.reply_markup = keyboard
        }
    }
    
    var command: Command? {
        guard let text else { return nil }
        let prefix = "/"
        guard text.hasPrefix(prefix) else { return nil }
        return .init(rawValue: text)
    }
    
    func reply(with text: String, keyboard: InlineKeyboardMarkup? = nil) -> Out {
        .init(chat_id: "\(chat.id)", text: text, keyboard: keyboard)
    }
}
