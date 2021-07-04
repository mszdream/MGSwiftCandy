//
//  ViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 06/21/2021.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import UIKit
import MGSwiftCandy

class ViewController: MGBaseViewController {
    var index = 0
    var titles: [String] = []
    
    override func generatingData() {
        // MARK: - Extension
        do {
            /// CoreGraphics
            #if MGSwiftCandy_Extension_CoreGraphics
            addItem(title: "Size", className: "MGTestSizeViewController", section: index)
            index += 1
            titles.append("CoreGraphics")
            #endif
            
            // MARK: - Foundation
            #if MGSwiftCandy_Extension_Foundation
            addItem(title: "Codable", className: "MGTestCodableViewController", section: index)
            addItem(title: "Array", className: "MGTestArrayViewController", section: index)
            index += 1
            titles.append("Foundation")
            #endif
            
            // MARK: - Swift
            #if MGSwiftCandy_Extension_Swift
            addItem(title: "Bool", className: "MGTestBoolViewController", section: index)
            addItem(title: "Double", className: "MGTestDoubleViewController", section: index)
            addItem(title: "Float", className: "MGTestFloatViewController", section: index)
            addItem(title: "Int", className: "MGTestIntViewController", section: index)
            addItem(title: "String", className: "MGTestStringViewController", section: index)
            index += 1
            titles.append("Swift")
            #endif
            
            // MARK: - UIKit
            #if MGSwiftCandy_Extension_UIKit
            addItem(title: "Color", className: "MGTestColorViewController", section: index)
            addItem(title: "Image", className: "MGTestImageViewController", section: index)
            addItem(title: "View", className: "MGTestViewViewController", section: index)
            addItem(title: "Screen", className: "MGTestScreenViewController", section: index)
            addItem(title: "Button", className: "MGTestButtonViewController", section: index)
            index += 1
            titles.append("UIKit")
            #endif
        }
        
        // MARK: - Tools
        do {
            #if MGSwiftCandy_Tools
            #if MGSwiftCandy_Tools_Eventer
            addItem(title: "Eventer", className: "MGTestEventerViewController", section: index)
            #endif
            #if MGSwiftCandy_Tools_Printer
            addItem(title: "Printer", className: "MGTestPrinterViewController", section: index)
            #endif
            #if MGSwiftCandy_Tools_keychain
            addItem(title: "Keychain", className: "MGTestKeychainViewController", section: index)
            #endif
            #if MGSwiftCandy_Tools_UserDefaults
            addItem(title: "UserDefaults", className: "MGTestUserDefaultsViewController", section: index)
            #endif
            index += 1
            titles.append("Tools")
            #endif
        }
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? UITableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        
        cell.textLabel?.text = model.title
    }

    override func title(section: Int) -> String? {
        return titles[section]
    }
    
    override func cellClicked(model: MGModelProtocol) {
        guard let model = model as? MGListItemModel,
              let vc: UIViewController = MGTools.mg.create(className: model.className),
              let topVc = UIViewController.mg.topViewController() else {
            return
        }
        
        topVc.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController {
    class MGListItemModel: MGModelProtocol {
        var title: String
        var className: String
        init(title: String, className: String) {
            self.title = title
            self.className = className
        }
    }
    
    private func addItem(title: String, className: String, section: Int) {
        let model = MGListItemModel(title: title, className: className)
        super.addDataModel(model: model, section: section)
    }
    
}

 
extension MGObject: MGCreate {}
