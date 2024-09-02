//
//  FileHelper.swift
//  CrashHandlingSample
//
//  Created by Pavel Yevtukhov on 02.09.2024.
//

import Foundation

struct FileLogger {
    let fileName: String

    func log(_ message: String) {
        guard let fileUrl = fileUrl() else {
            return
        }

        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
        }
        guard let fileHandle = try? FileHandle(forWritingTo: fileUrl) else {
            return
        }
        fileHandle.seekToEndOfFile()
        if let data = message.data(using: .utf8) {
            fileHandle.write(data)
        }
        fileHandle.closeFile()
    }

    func clear() {
        guard let url = fileUrl() else { return }

        try? FileManager.default.removeItem(at: url)
    }

    func read() -> String? {
        guard let url = fileUrl() else { return nil }
        return try? String(contentsOf: url, encoding: .utf8)
    }

    private func fileUrl() -> URL? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return cachesDirectory.appendingPathComponent(fileName)
    }
}

