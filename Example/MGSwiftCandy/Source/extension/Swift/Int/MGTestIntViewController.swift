//
//  MGTestIntViewController.swift
//  MGSwiftCandy_Example
//
//  Created by msz on 2021/7/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#if MGSwiftCandy_Extension_Swift

import UIKit

class MGTestIntViewController: MGBaseViewController {
    override func generatingData() {
        addItem(title: "stringify", desc: 88.mg.stringify)
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? MGTableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.attributedText = nil
        
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.desc
        if let attrDesc = model.attrDesc {
            cell.detailTextLabel?.attributedText = attrDesc
        }
        
    }

    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestIntViewController {
    class MGListItemModel: MGModelProtocol {
        var title: String = ""
        var desc: String = ""
        var attrDesc: NSAttributedString?
        init(title: String, desc: String, attrDesc: NSAttributedString?) {
            self.title = title
            self.desc = desc
            self.attrDesc = attrDesc
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
    
    private func addItem(title: String, desc: String, attrDesc: NSAttributedString? = nil) {
        let model = MGListItemModel(title: title, desc: desc, attrDesc: attrDesc)
        super.addDataModel(model: model)
    }
}

#endif
