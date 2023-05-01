
import Bots
import Vapor

extension Bot: ChatBot {
    
    public convenience init(app: Application) {
        self.init(app)
    }
}

extension BotID {
    
    public static let telegram: BotID = .init(rawValue: "telegram")
}
