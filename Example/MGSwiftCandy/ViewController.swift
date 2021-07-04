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
    override func generatingData() {
        // MARK: - Extension
        do {
            /// CoreGraphics
            addItem(title: "Size", className: "MGTestSizeViewController", section: 0)
            
            // MARK: - Foundation
            addItem(title: "Codable", className: "MGTestCodableViewController", section: 1)
            addItem(title: "Array", className: "MGTestArrayViewController", section: 1)
            
            // MARK: - Swift
            addItem(title: "Bool", className: "MGTestBoolViewController", section: 2)
            addItem(title: "Double", className: "MGTestDoubleViewController", section: 2)
            addItem(title: "Float", className: "MGTestFloatViewController", section: 2)
            addItem(title: "Int", className: "MGTestIntViewController", section: 2)
            addItem(title: "String", className: "MGTestStringViewController", section: 2)
            
            // MARK: - UIKit
            addItem(title: "Color", className: "MGTestColorViewController", section: 3)
            addItem(title: "Image", className: "MGTestImageViewController", section: 3)
            addItem(title: "View", className: "MGTestViewViewController", section: 3)
            addItem(title: "Screen", className: "MGTestScreenViewController", section: 3)
            addItem(title: "Button", className: "MGTestButtonViewController", section: 3)
        }
        
        // MARK: - Tools
        do {
            addItem(title: "Eventer", className: "MGTestEventerViewController", section: 4)
            addItem(title: "Printer", className: "MGTestPrinterViewController", section: 4)
            addItem(title: "Keychain", className: "MGTestKeychainViewController", section: 4)
            addItem(title: "UserDefaults", className: "MGTestUserDefaultsViewController", section: 4)
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
        switch section {
        case 0:
            return "CoreGraphics"
        case 1:
            return "Foundation"
        case 2:
            return "Swift"
        case 3:
            return "UIKit"
        case 4:
            return "Tools"
        default:
            return nil
        }
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
