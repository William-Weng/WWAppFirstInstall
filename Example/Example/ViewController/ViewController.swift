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

    override func viewDidLoad() {
        super.viewDidLoad()
        demo()
    }
}

// MARK: - 小工具
private extension ViewController {
    
    func demo() {
        
        let appIdArray = [
            "idv.william.Example1",
            "idv.william.Example2",
            "idv.william.Example3",
        ]
        
        wwPrint("DICT => \(WWAppFirstInstall.shared.dictionary())")

        appIdArray.forEach { appId in
            _ = WWAppFirstInstall.shared.insert(appId: appId)
            wwPrint("DICT => \(WWAppFirstInstall.shared.dictionary()!)")
        }
        
        appIdArray.forEach { appId in
            wwPrint(WWAppFirstInstall.shared.installTime(appId: appId))
        }
        
        _ = WWAppFirstInstall.shared.reset(appId: appIdArray[1])
        wwPrint("DICT => \(WWAppFirstInstall.shared.dictionary()!)")
    }
}
