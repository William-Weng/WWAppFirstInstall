//
//  Extension.swift
//  WWAppFirstInstall
//
//  Created by William.Weng on 2024/8/8.
//

import UIKit

// MARK: - Data (function)
extension Data {
    
    /// [Data => JSON](https://blog.zhgchg.li/現實使用-codable-上遇到的-decode-問題場景總匯-下-cb00b1977537)
    /// - 7b2268747470223a2022626f6479227d => {"http": "body"}
    /// - Returns: Any?
    func _jsonObject(options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        let json = try? JSONSerialization.jsonObject(with: self, options: options)
        return json
    }
    
    /// Data => 字串
    /// - Parameter encoding: 字元編碼
    /// - Returns: String?
    func _string(using encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}

// MARK: - String (function)
extension String {
    
    /// JSON String => [String: Any]
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - options: JSON序列化讀取方式
    /// - Returns: Any?
    func _dictionary(encoding: String.Encoding, options: JSONSerialization.ReadingOptions = .allowFragments) -> [String: Any]? {
        let dictionary = self._jsonObject(encoding: encoding, options: options) as? [String: Any]
        return dictionary
    }
    
    /// String => Data
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - isLossyConversion: 失真轉換
    /// - Returns: Data?
    func _data(using encoding: String.Encoding = .utf8, isLossyConversion: Bool = false) -> Data? {
        let data = self.data(using: encoding, allowLossyConversion: isLossyConversion)
        return data
    }
    
    /// JSON String => JSON Object
    /// - Parameters:
    ///   - encoding: 字元編碼
    ///   - options: JSON序列化讀取方式
    /// - Returns: Any?
    func _jsonObject(encoding: String.Encoding = .utf8, options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        
        guard let data = self._data(using: encoding),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: options)
        else {
            return nil
        }
        
        return jsonObject
    }
}

// MARK: - Dictionary (function)
extension Dictionary {
    
    /// Dictionary => JSON Data
    /// - ["name":"William"] => {"name":"William"} => 7b226e616d65223a2257696c6c69616d227d
    /// - Parameter options: JSONSerialization.WritingOptions
    /// - Returns: Data?
    func _jsonData(options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data? {
        return JSONSerialization._data(with: self, options: options)
    }
    
    /// Dictionary => JSON Object
    /// - Parameters:
    ///   - options: JSONSerialization.WritingOptions
    /// - Returns: Any?
    func _jsonObject(options: JSONSerialization.WritingOptions = .prettyPrinted) -> Any? {
        
        guard let data = self._jsonData(options: options),
              let jsonObject = data._jsonObject()
        else {
            return nil
        }
        
        return jsonObject
    }
    
    /// Dictionary => JSON String
    /// - Parameters:
    ///   - options: JSONSerialization.WritingOptions
    ///   - encoding: String.Encoding
    /// - Returns: String?
    func _jsonString(options: JSONSerialization.WritingOptions = .prettyPrinted, using encoding: String.Encoding = .utf8) -> String? {
        
        guard let data = self._jsonData(options: options),
              let jsonString = data._string(using: encoding)
        else {
            return nil
        }
        
        return jsonString
    }
}

// MARK: - JSONSerialization (static function)
extension JSONSerialization {
    
    /// [JSONObject => JSON Data](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-jsonserialization-印出美美縮排的-json-308c93b51643)
    /// - ["name":"William"] => {"name":"William"} => 7b226e616d65223a2257696c6c69616d227d
    /// - Parameters:
    ///   - object: Any
    ///   - options: JSONSerialization.WritingOptions
    /// - Returns: Data?
    static func _data(with object: Any, options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data? {
        
        guard JSONSerialization.isValidJSONObject(object),
              let data = try? JSONSerialization.data(withJSONObject: object, options: options)
        else {
            return nil
        }
        
        return data
    }
}
