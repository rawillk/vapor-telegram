
import Vapor

public struct Webhook: Content {
    
    public let url: String
    
    public init(url: String) {
        self.url = url
    }
}
