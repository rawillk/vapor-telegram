
import Vapor
import Telegram

struct TelegramController: ChatSession, RouteCollection {
    
    let bot: Bot
    
    init(bot: Bot) {
        self.bot = bot
    }
    
    func boot(routes: RoutesBuilder) throws {
        routes.get("command", use: command)
    }

    func command(_ req: Request) async throws -> String {
        let message = Message.Out(chat_id: "some_chat", text: "Dummy", keyboard: .init(collumns: [
            [.init(text: "Option 1", callback_data: "Some", url: nil), .init(text: "Option 2", callback_data: "Some2", url: nil)]
        ]))
        let msg = try await bot.send(message: message)
        print(msg)
        return "Good"
    }
}
