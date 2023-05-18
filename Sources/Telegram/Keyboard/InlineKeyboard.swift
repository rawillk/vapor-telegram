
import Vapor

public struct InlineKeyboardMarkup: Content {
    
    let inline_keyboard: [[InlineKeyboardButton]]
    
    public init(collumns: [[InlineKeyboardButton]]) {
        self.inline_keyboard = collumns
    }
}

public struct InlineKeyboardButton: Codable {
    
    public let text: String
    public let callback_data: String?
    public let url: String?
    
    public init(text: String, callback_data: String?, url: String?) {
        self.text = text
        self.callback_data = callback_data
        self.url = url
    }
}
