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
            fairplayConfig.prepareSyncMessage = { [weak self] syncSpcData, assetId in
                self?.handlePrepareSyncMessage(syncSpcData: syncSpcData, assetId: assetId) ?? syncSpcData
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

    private func handlePrepareContentId(contentId: String) -> String? {
        var prepareContentIdResult: String?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        let payload = [
            "contentId": contentId
        ]

        methodChannel.invokeMethod(Methods.fairplayPrepareContentId, arguments: payload) { result in
            guard let resultString = result as? String else {
                dispatchGroup.leave()
                return
            }

            prepareContentIdResult = resultString
            dispatchGroup.leave()
        }

        dispatchGroup.wait()
        return prepareContentIdResult
    }

    private func handlePrepareCertificate(certificate: Data) -> Data? {
        var prepareCertificateResult: Data?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        let payload = [
            "certificate": certificate.base64EncodedString()
        ]

        methodChannel.invokeMethod(Methods.fairplayPrepareCertificate, arguments: payload) { result in
            guard let resultString = result as? String,
                  let resultData = Data(base64Encoded: resultString) else {
                dispatchGroup.leave()
                return
            }

            prepareCertificateResult = resultData
            dispatchGroup.leave()
        }

        dispatchGroup.wait()
        return prepareCertificateResult
    }

    private func handlePrepareLicense(ckc: Data) -> Data? {
        var prepareLicenseResult: Data?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        let payload = [
            "ckc": ckc.base64EncodedString()
        ]

        methodChannel.invokeMethod(Methods.fairplayPrepareLicense, arguments: payload) { result in
            guard let resultString = result as? String,
                  let resultData = Data(base64Encoded: resultString) else {
                dispatchGroup.leave()
                return
            }

            prepareLicenseResult = resultData
            dispatchGroup.leave()
        }

        dispatchGroup.wait()
        return prepareLicenseResult
    }

    private func handlePrepareLicenseServerUrl(licenseServerUrl: String) -> String? {
        var prepareLicenseServerUrlResult: String?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        let payload = [
            "licenseServerUrl": licenseServerUrl
        ]

        methodChannel.invokeMethod(Methods.fairplayPrepareLicenseServerUrl, arguments: payload) { result in
            guard let resultString = result as? String else {
                dispatchGroup.leave()
                return
            }

            prepareLicenseServerUrlResult = resultString
            dispatchGroup.leave()
        }

        dispatchGroup.wait()
        return prepareLicenseServerUrlResult
    }

    private func handlePrepareSyncMessage(syncSpcData: Data, assetId: String) -> Data? {
        var prepareSyncMessageResult: Data?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        let payload = [
            "syncSpcData": syncSpcData.base64EncodedString(),
            "assetId": assetId
        ]

        methodChannel.invokeMethod(Methods.fairplayPrepareSyncMessage, arguments: payload) { result in
            guard let resultString = result as? String,
                  let resultData = Data(base64Encoded: resultString) else {
                dispatchGroup.leave()
                return
            }

            prepareSyncMessageResult = resultData
            dispatchGroup.leave()
        }

        dispatchGroup.wait()
        return prepareSyncMessageResult
    }
}
