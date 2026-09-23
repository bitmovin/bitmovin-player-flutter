import BitmovinPlayer
import Foundation

extension FairplayConfig {
    struct Metadata {
        let hasPrepareMessage: Bool
        let hasPrepareContentId: Bool
        let hasPrepareCertificate: Bool
        let hasPrepareLicense: Bool
        let hasPrepareLicenseServerUrl: Bool
        let hasPrepareSyncMessage: Bool
    }
}
