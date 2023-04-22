//  Logger.swift
//  Created by bemohansingh on 12/12/2021.


import Foundation

public enum LogLevel {
    case none, info, debug
}

public class Logger {
    
    internal var level: LogLevel = .none
    
    public static let current = Logger()
    private init() {}
    
    public func set(with level: LogLevel) {
        self.level = level
    }
}


/// Static accessor

public func log(_ items: Any...) {
    Logger.current.log(items)
}

public func log(request: URLRequest, response: URLResponse?, error: Error?, data: Data?) {
    Logger.current.log(request: request, response: response, error: error, data: data)
}

public func log(request: URLRequest?, response: URLResponse?, error: Error?, data: Data?) {
    Logger.current.log(request: request, response: response, error: error, data: data)
}
