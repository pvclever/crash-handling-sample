//
//  CrashSimulator.swift
//  CrashHandlingSample
//
//  Created by Pavel Yevtukhov on 02.09.2024.
//

import Foundation

enum CrashSimulator {
    static func simulateError1() {
        for a in (0...10) {
            print(10/a)
        }
    }

    static func simulateError2() {
        let pointer: UnsafeMutablePointer<Int>? = nil
        pointer!.pointee = 42
    }

    static func simulateException() {
        let array = NSArray()
        print(array.object(at: 1))
    }
}
