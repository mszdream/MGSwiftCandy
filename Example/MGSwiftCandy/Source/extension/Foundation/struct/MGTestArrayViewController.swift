//
//  MGTestArrayViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/5/25.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit

class MGTestArrayViewController: MGBaseViewController {
    override func generatingData() {
        
        /// property
        addItem(title: "length", desc: "\([1, 3, 5].mg.length)", section: 0)
        addItem(title: "isNotEmpty", desc: "\([].mg.isNotEmpty)", section: 0)
        
        /// method
        var array = [1]
        array.mg.apend(2)
        addItem(title: "apend", desc: "\(array)", section: 1)
        array.mg.preApend(3)
        addItem(title: "preApend", desc: "\(array)", section: 1)
        array.mg.insert(4, at: 3)
        addItem(title: "insert", desc: "\(array)", section: 1)
        addItem(title: "element", desc: "\(String(describing: array.mg.element(at: 1)))", section: 1)
        addItem(title: "[index]", desc: "\(String(describing: array.mg[3]))", section: 1)
        addItem(title: "item", desc: "\(String(describing: array.mg.item(at: 2)))", section: 1)

        /// stack
        var stack = [1]
        stack.mg.push(2)
        addItem(title: "push", desc: "\(stack)", section: 2)
        stack.mg.pop()
        addItem(title: "pop", desc: "\(stack)", section: 2)
        
        /// extension method
        addItem(title: "sum", desc: String([1, 2, 3].mg.sum()), section: 3)
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

    override func title(section: Int) -> String? {
        switch section {
        case 0:
            return "property"
        case 1:
            return "method"
        case 2:
            return "stack"
        case 3:
            return "extension method"
        default:
            return nil
        }
    }
    
    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestArrayViewController {
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

