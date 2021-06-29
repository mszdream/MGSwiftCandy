//
//  MGTestUserDefaultsViewController.swift
//  MGSwiftCandy_Example
//
//  Created by msz on 2021/6/29.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MGSwiftCandy

class MGTestUserDefaultsViewController: MGBaseViewController {
    let key = "name"
    let value = "zhang san"
    
    override func generatingData() {
        MGUserDefaults.mg.set(key: key, value: value)
        addItem(title: "set", desc: value, section: 0)
        
        if let desc: String? = MGUserDefaults.mg.get(key: key),
           let desc = desc {
            addItem(title: "get", desc: desc, section: 0)
        }
        
        MGUserDefaults.mg.remove(key: key)
        addItem(title: "remove", desc: value, section: 0)
        
        // We will not get the content, because we have removed the content in key used the remove method 
        if let desc: String? = MGUserDefaults.mg.get(key: key),
           let desc = desc {
            addItem(title: "get", desc: desc, section: 0)
        }
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? UITableViewCell,
              let model = model as? MGListItemModel else {
            return
        }

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = model.title
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = model.desc
    }
    
    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestUserDefaultsViewController {
    class MGListItemModel: MGModelProtocol {
        var title: String = ""
        var desc: String = ""
        init(title: String, desc: String) {
            self.title = title
            self.desc = desc
        }
    }
    
    class MGTableViewCell: UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    private func addItem(title: String, desc: String, section: Int) {
        let model = MGListItemModel(title: title, desc: desc)
        super.addDataModel(model: model, section: section)
    }
    
}
