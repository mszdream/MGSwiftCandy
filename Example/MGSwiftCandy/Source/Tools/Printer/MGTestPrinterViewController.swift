//
//  MGTestPrinterViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/6/23.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import MGSwiftCandy

class MGTestPrinterViewController: MGBaseViewController {
    override func generatingData() {
        let log = "hello baby"
        var target = ""
        MGPrinter.mg.printer(log, target: &target)
        addItem(title: "printer", desc: target, section: 0)
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

extension MGTestPrinterViewController {
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

