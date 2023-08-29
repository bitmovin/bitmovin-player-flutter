import Foundation

class MessageDecoder {
    static func decode<T: Decodable>(type: T.Type, from data: Any?) -> T? {
        guard let dataDict = data as? [String: Any],
              let jsonData = try? JSONSerialization.data(withJSONObject: dataDict) else {
            return nil
        }

        return try? JSONDecoder().decode(type.self, from: jsonData)
    }
}
