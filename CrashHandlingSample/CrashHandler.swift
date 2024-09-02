//
//  CrashHandler.swift
//  CrashHandlingSample
//
//  Created by Pavel Yevtukhov on 30.08.2024.
//

import Foundation


/// DO NOT this CrashHandler along with other crash handlers like Firebase Crashlytics, Sentry, etc
enum CrashHandler {
    private static let fileLogger = FileLogger(fileName: "crash.txt")

    static func getCrashLog() -> String? {
        fileLogger.read()
    }

    static func cleanCrashLog() {
        fileLogger.clear()
    }

    static func setup() {
        NSSetUncaughtExceptionHandler { exception in
            let callStack = exception.callStackSymbols
            let logMessage = "Uncaught Exception: \(exception)\n\n\(callStack)"
            CrashHandler.fileLogger.log(logMessage)
        }

        signal(SIGABRT) { signal in CrashHandler.signalHandler(signal) }
        signal(SIGSEGV) { signal in CrashHandler.signalHandler(signal) }
        signal(SIGILL) { signal in CrashHandler.signalHandler(signal) }
        signal(SIGFPE) { signal in CrashHandler.signalHandler(signal) }
        signal(SIGBUS) { signal in CrashHandler.signalHandler(signal) }
        signal(SIGTRAP) { signal in CrashHandler.signalHandler(signal) }
    }

    private static func signalHandler(_ code: Int32) {
        let callStack = Thread.callStackSymbols
        let logMessage = "\n Crashed at signal: \(code)\n\n\(callStack)"
        CrashHandler.fileLogger.log(logMessage)
        
        signal(code, SIG_DFL) // set default behavior
        raise(code) // let the app handle the signal on its own (i.e. crash)
    }
}
