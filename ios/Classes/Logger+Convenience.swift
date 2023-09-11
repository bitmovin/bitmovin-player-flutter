import BitmovinPlayer
import Foundation

extension Logger {
    func log(_ message: String, _ level: LogLevel, _ sender: String = #file) {
        self.log(
            LogEntry(
                message: message,
                level: level,
                code: nil,
                sender: sender,
                data: nil
            )
        )
    }
}

internal func getLogger() -> Logger {
    DebugConfig.logging.logger ?? ConsoleLogger()
}
