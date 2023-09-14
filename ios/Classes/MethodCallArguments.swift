import Foundation

internal enum MethodCallArguments {
    case json([String: Any])
    case double(Double)
    case string(String)
    case empty
}
