import Foundation

public enum SwiftAgeError: Error, LocalizedError, CustomStringConvertible {
    
    case ageNotInstalled
    
    /// See `LocalizedError`.
    public var errorDescription: String? {
        return self.description
    }
    
    /// See `CustomStringConvertible`.
    public var description: String {
        let description: String
        switch self {
        case .ageNotInstalled:
            description = "Apache AGE is not installed"
        }
        return "SwiftAge error: \(description)"
    }
}
