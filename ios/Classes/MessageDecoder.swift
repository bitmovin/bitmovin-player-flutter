import Foundation

class MessageDecoder {
    static func decode<T: Decodable>(type: T.Type, from data: Any?) -> T? {
        guard let dataDict = data as? [String: Any],
              let jsonData = try? JSONSerialization.data(withJSONObject: dataDict) else {
            return nil
        }

        return try? JSONDecoder().decode(type.self, from: jsonData)
    }

    static func toNative<T: FlutterToNativeConvertible>(type: T.Type, from data: Any?) -> T.NativeObject? {
        guard let dataDict = data as? [String: Any],
              let jsonData = try? JSONSerialization.data(withJSONObject: dataDict),
              let decoded = try? JSONDecoder().decode(type.self, from: jsonData) else {
            return nil
        }

        return decoded.toNative()
    }
}
