
import Bots
import Vapor

extension Bot: ChatBot {
    
    public convenience init(app: Application) {
        self.init(client: app.client, logger: app.logger)
    }
}

extension BotID {
    
    public static let telegram: BotID = .init(rawValue: "telegram")
}
