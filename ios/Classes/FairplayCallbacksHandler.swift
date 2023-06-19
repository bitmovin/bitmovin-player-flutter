import BitmovinPlayer
import Flutter
import Foundation

internal class FairplayCallbacksHandler {
    private let fairplayConfig: FairplayConfig
    private let metadata: FairplayConfig.Metadata
    private let methodChannel: FlutterMethodChannel

    init(
        fairplayConfig: FairplayConfig,
        metadata: FairplayConfig.Metadata,
        methodChannel: FlutterMethodChannel
    ) {
        self.fairplayConfig = fairplayConfig
        self.metadata = metadata
        self.methodChannel = methodChannel

        self.assignHandlers()
    }

    private func assignHandlers() {
        if metadata.hasPrepareMessage {
            fairplayConfig.prepareMessage = { [weak self] spcData, assetId in
                self?.handlePrepareMessage(spcData: spcData, assetId: assetId) ?? spcData
            }
        }

        if metadata.hasPrepareContentId {
            fairplayConfig.prepareContentId = { [weak self] contentId in
                self?.handlePrepareContentId(contentId: contentId) ?? contentId
            }
        }

        if metadata.hasPrepareCertificate {
            fairplayConfig.prepareCertificate = { [weak self] certificate in
                self?.handlePrepareCertificate(certificate: certificate) ?? certificate
            }
        }

        if metadata.hasPrepareLicense {
            fairplayConfig.prepareLicense = { [weak self] ckc in
                self?.handlePrepareLicense(ckc: ckc) ?? ckc
            }
        }

        if metadata.hasPrepareLicenseServerUrl {
            fairplayConfig.prepareLicenseServerUrl = { [weak self] licenseServerUrl in
                self?.handlePrepareLicenseServerUrl(licenseServerUrl: licenseServerUrl) ?? licenseServerUrl
            }
        }

        if metadata.hasPrepareSyncMessage {
            fairplayConfig.prepareSyncMessage = { [weak self] syncSpcData, assetID in
                self?.handlePrepareSyncMessage(syncSpcData: syncSpcData, assetID: assetID) ?? syncSpcData
            }
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

    private func handlePrepareContentId(contentId: String) -> String {
        "" // TODO: implement
    }

    private func handlePrepareCertificate(certificate: Data) -> Data {
        Data() // TODO: implement
    }

    private func handlePrepareLicense(ckc: Data) -> Data {
        Data() // TODO: implement
    }

    private func handlePrepareLicenseServerUrl(licenseServerUrl: String) -> String {
        "" // TODO: implement
    }

    private func handlePrepareSyncMessage(syncSpcData: Data, assetID: String) -> Data {
        Data() // TODO: implement
    }
}
