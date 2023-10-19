import Flutter
import Foundation

internal enum BitmovinError: Error {
    case parsingError(String)
    case unknownMethod(String)
}

extension FlutterError {
    enum ErrorCodes {
        static let general = "General"
    }

    static func from(_ bitmovinError: BitmovinError) -> FlutterError {
        let errorMessage: String

        switch bitmovinError {
        case .parsingError(let message):
            errorMessage = "Parsing error: \(message)"
        case .unknownMethod(let message):
            errorMessage = "Unknown method: \(message)"
        }

        return FlutterError(
            code: ErrorCodes.general,
            message: errorMessage,
            details: nil
        )
    }

    static func general(_ errorMessage: String) -> FlutterError {
        FlutterError(
            code: ErrorCodes.general,
            message: errorMessage,
            details: nil
        )
    }
}
