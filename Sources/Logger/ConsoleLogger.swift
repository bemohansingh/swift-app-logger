//  ConsoleLogger.swift
//  Created by bemohansingh on 06/01/2022.


import Foundation

// MARK: Simple Log
typealias ConsoleLogger = Logger
public extension ConsoleLogger {
    func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        guard level != .none else { return }
        debugPrint(items, separator: separator,terminator: terminator)
    }
}
