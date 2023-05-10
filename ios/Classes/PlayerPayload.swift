import Foundation

class PlayerPayload {
    var id: Int?
    var data: Any?

    init() {}

    init(id: Int, data: Any?) {
        self.id = id
        self.data = data
    }
}
