
import Vapor

public struct API {
    
    let baseURL = "https://api.telegram.org/bot"
    let token = Environment.get("TELETGRAM_BOT_TOKEN")!
    
    func uri(_ method: Method) -> URI {
        .init(stringLiteral: baseURL + "\(token)/\(method.rawValue)")
    }
    
    enum Method: String {
        case getMe
        case logOut
        case close
        case sendMessage
        case getUpdates
        case setWebhook
        case deleteWebhook
        case getWebhookInfo
    }
    
    struct Payload<R: Content>: Content {
        let ok: Bool
        let result: R
    }
    
    struct EmptyPayload: Content {
        let ok: Bool
    }
}
