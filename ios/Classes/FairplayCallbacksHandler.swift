import BitmovinPlayer
import Flutter
import Foundation

internal class FairplayCallbacksHandler {
    let fairplayConfig: FairplayConfig
    private let methodChannel: FlutterMethodChannel

    init(
        fairplayConfig: FairplayConfig,
        methodChannel: FlutterMethodChannel
    ) {
        self.fairplayConfig = fairplayConfig
        self.methodChannel = methodChannel

        fairplayConfig.prepareMessage = { [weak self] spcData, assetId in
            return self?.handlePrepareMessage(spcData: spcData, assetId: assetId) ?? Data()
        }
    }

    private func handlePrepareMessage(spcData: Data, assetId: String) -> Data? {
        var prepareMessageResult: Data?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        let payload = [
            "spcData": spcData.base64EncodedString(),
            "assetId": assetId
        ]

        methodChannel.invokeMethod(Methods.fairplayPrepareMessage, arguments: payload) { result in
            guard let resultString = result as? String,
                  let resultData = Data(base64Encoded: resultString) else {
                dispatchGroup.leave()
                return
            }

            prepareMessageResult = resultData
            dispatchGroup.leave()
        }

        dispatchGroup.wait()
        return prepareMessageResult
    }
}
