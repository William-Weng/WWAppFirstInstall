//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/8/8.
//

import UIKit
import WWPrint
import WWAppFirstInstall

// MARK: - ViewController
final class ViewController: UIViewController {

    let firstInstall = WWAppFirstInstall(key: "My-APP-Team")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demo()
    }
}

// MARK: - 小工具
private extension ViewController {
    
    func demo() {
        
        firstInstall.clean()
        
        let appIdArray = [
            "idv.william.Example1",
            "idv.william.Example2",
            "idv.william.Example3",
        ]
        
        wwPrint("DICT => \(firstInstall.dictionary()!)")

        appIdArray.forEach { appId in
            _ = firstInstall.insert(appId: appId)
            wwPrint("DICT => \(firstInstall.dictionary()!)")
        }
        
        appIdArray.forEach { appId in
            wwPrint(firstInstall.installTime(appId: appId))
        }
        
        _ = firstInstall.reset(appId: appIdArray[1])
        wwPrint("DICT => \(firstInstall.dictionary()!)")
    }
}
