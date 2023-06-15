import Foundation

class PlayerPayload {
    let id: Int
    let data: [String: Any]?

    init(id: Int, data: [String: Any]? = nil) {
        self.id = id
        self.data = data
    }
}
