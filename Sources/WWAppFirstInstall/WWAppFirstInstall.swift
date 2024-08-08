//
//  WWAppFirstInstall.swift
//  WWAppFirstInstall
//
//  Created by William.Weng on 2024/8/8.
//

import UIKit
import WWPrint
import WWKeychain

// MARK: - WWAppFirstInstall (單例)
open class WWAppFirstInstall: NSObject {
    
    public static let shared = WWAppFirstInstall()
    
    @WWKeychain("WWAppFirstInstall") var jsonString: String?
    
    private override init() {}
}

// MARK: - 小工具
public extension WWAppFirstInstall {
        
    /// 加入AppId到紀錄之中
    /// - Parameter appId: String
    /// - Returns: Bool
    func insert(appId: String) -> Bool {
        
        guard !detect(appId: appId) else { return false }
        return insertAppId(appId)
    }
    
    /// 檢測該AppId是否有安裝過？
    /// - Parameter appId: String
    /// - Returns: Bool
    func detect(appId: String) -> Bool {
        
        guard let dictionary = dictionary() else { return false }
        
        if let info = dictionary[appId] { return true }
        return false
    }
    
    /// 將安裝過的記錄刪除
    /// - Parameter appId: String
    /// - Returns: Bool
    func reset(appId: String) -> Bool {
        
        guard var dictionary = dictionary() else { return false }
        
        if let info = dictionary[appId] {
            dictionary[appId] = nil
            self.jsonString = dictionary._jsonString(options: .withoutEscapingSlashes)
            return true
        }
        
        return false
    }
    
    /// 取得安裝時間 (秒)
    /// - Parameter appId: String
    /// - Returns: Int?
    func installTime(appId: String) -> Int? {
        guard var dictionary = dictionary() else { return nil }
        return dictionary[appId]
    }
    
    /// 取得安裝過的全記錄 => [<AppId>: <安裝時間>]
    /// - Returns: [String: Int]?
    func dictionary() -> [String: Int]? {
        
        guard let jsonObject = jsonString?._jsonObject(),
              let dictionary = jsonObject as? [String: Int]
        else {
            return nil
        }
        
        return dictionary
    }
    
    /// 全紀錄清除
    func clean() {
        jsonString = nil
    }
}

// MARK: - 小工具
private extension WWAppFirstInstall {
        
    /// 記錄AppId + 安裝時間
    /// - Parameter appId: String
    func insertAppId(_ appId: String) -> Bool {
        
        if var dictionary = dictionary(), !dictionary.isEmpty {
            
            if let info = dictionary[appId] { return false }
            
            dictionary[appId] = installTime()
            self.jsonString = dictionary._jsonString()

            return true
        }
        
        let dict = [appId: installTime()]
        self.jsonString = dict._jsonString()
        
        return true
    }
    
    /// 安裝時間 (秒)
    /// - Returns: Int
    func installTime() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}

