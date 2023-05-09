
import Foundation

public struct Command: Codable, Hashable, Equatable {
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static let start = Command(rawValue: "/start")
}
