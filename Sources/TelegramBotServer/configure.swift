
import Vapor
import Telegram

// configures your application
public func configure(_ app: Application) async throws {
    
    let bot = app.bots.use(Telegram.Bot.self, as: .telegram)
    let controller = bot.register(TelegramController.self)
    
    try app.register(collection: controller)
}
