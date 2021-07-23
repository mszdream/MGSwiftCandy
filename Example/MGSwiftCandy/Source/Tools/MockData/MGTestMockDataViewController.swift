//
//  MGTestMockDataViewController.swift
//  MGSwiftCandy_Example
//
//  Created by hello on 2021/7/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#if MGSwiftCandy_Tools_MockData

import UIKit
import MGSwiftCandy

/// Need to add the micro(-D MOCKDATA) in debug module
class MGTestMockDataViewController: MGBaseViewController, MGMockDataProtocol {
    override func generatingData() {
        var name = ""
        mockData {
            name = "zhang san"
        }
        
        addItem(title: "mockData", desc: name, section: 0)
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

extension MGTestMockDataViewController {
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

#endif
