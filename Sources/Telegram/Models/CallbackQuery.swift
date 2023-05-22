
import Vapor

public struct CallbackQuery: Content {
    
    public let id: String
    public let from: User
    public let message: Message?
    public let data: String?
}

public extension CallbackQuery {

    struct Answer: Content {

        let callback_query_id: String
        let text: String?
        let show_alert: Bool?
    }

    func answer(text: String? = nil, showAlert: Bool? = nil) -> Answer {
        .init(callback_query_id: id, text: text, show_alert: showAlert)
    }
}
