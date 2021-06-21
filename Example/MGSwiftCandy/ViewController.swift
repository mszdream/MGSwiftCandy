//
//  ViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 06/21/2021.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import UIKit
import MGSwiftCandy

class ViewController: MGBaseViewController {
    override func generatingData() {
        // MARK: - Foundation
        addItem(title: "Codable", className: "MGTestCodableViewController", section: 0)
        addItem(title: "Array", className: "MGTestArrayViewController", section: 0)
        addItem(title: "String", className: "MGTestStringViewController", section: 0)
        
        // MARK: - UIKit
        addItem(title: "Color", className: "MGTestColorViewController", section: 1)
        addItem(title: "Image", className: "MGTestImageViewController", section: 1)
        addItem(title: "View", className: "MGTestViewViewController", section: 1)
        addItem(title: "Screen", className: "MGTestScreenViewController", section: 1)
        addItem(title: "Button", className: "MGTestButtonViewController", section: 1)
        
        // MARK: - Tools
        addItem(title: "Eventer", className: "MGTestEventerViewController", section: 2)
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
            return "Foundation"
        case 1:
            return "UIKit"
        case 2:
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
