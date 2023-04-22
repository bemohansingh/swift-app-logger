//  NetwokLogger.swift
//  Created by bemohansingh on 06/01/2022.

import Foundation

// MARK: Log Request
typealias NetworkLogger = Logger
extension NetworkLogger {
    
    func log(request: URLRequest?, response: URLResponse?, error: Error?, data: Data?) {
        guard level != .none else { return }
        let requestObject = getRequestData(request: request)
        let responseObject = getResponseData(response: response, data: data)

        var requestResponse = [String: Any]()
        requestResponse["REQUEST"] = requestObject
        requestResponse["RESPONSE"] = responseObject
        if let error = error {
            requestResponse["ERROR"] = error.localizedDescription
        }
    
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestResponse, options: .prettyPrinted)
            print(String(data: jsonData, encoding: .utf8) ?? "Empty")
        } catch {
            print("Unable to convert log to data")
        }
    }
    
    func log(request: URLRequest, response: URLResponse, receivedData: Data) {
        guard level != .none else { return }
        let requestObject = getRequestData(request: request)
        let responseObject = getResponseData(response: response, data: receivedData)
        
        var requestResponse = [String: Any]()
        requestResponse["REQUEST"] = requestObject
        requestResponse["RESPONSE"] = responseObject
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestResponse, options: .prettyPrinted)
            print(String(data: jsonData, encoding: .utf8) ?? "Empty")
        } catch {
            print("Unable to convert log to data")
        }
    }
    
    private func getRequestData(request: URLRequest?) -> [String: Any] {
        guard let request = request else { return [:] }
        var requestObject = [String: Any]()
        do {
            if let httpBody = request.httpBody {
                let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                requestObject["RequestData"] = json
            }
        } catch {
            if let httpBody = request.httpBody {
                if let stringData = String(data: httpBody, encoding: .utf8) {
                    requestObject["RequestData"] = stringData
                }
            }
        }
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            requestObject["headers"] = headers
        }
        
        if let httpMethod = request.httpMethod {
            requestObject["method"] = httpMethod
        }
        
        if let apiLink = request.url?.absoluteString {
            requestObject["endpoint"] = apiLink
        }
        
        return requestObject
    }
    
    private func getResponseData(response: URLResponse?, data: Data?) -> [String: Any] {
        guard let response = response else { return [:] }
        var responseObject = [String: Any]()
        if level == .debug, let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                responseObject["responseData"] = json
            } catch {
                if let stringData = String(data: data, encoding: .utf8) {
                    responseObject["responseData"] = stringData
                }
            }
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            responseObject["headers"] = httpResponse.allHeaderFields
            responseObject["statusCode"] = httpResponse.statusCode
        }
        
        return responseObject
    }
}
