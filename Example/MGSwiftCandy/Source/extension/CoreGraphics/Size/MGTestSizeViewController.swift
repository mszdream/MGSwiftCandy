//
//  MGTestSizeViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/6/23.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

#if MGSwiftCandy_Extension_CoreGraphics

import UIKit

class MGTestSizeViewController: MGBaseViewController {
    override func generatingData() {
        
        /// property
        let size1 = CGSize(width: 100, height: 50)
        addItem(title: "aspectRatio", desc: "\(size1.mg.aspectRatio)", section: 0)
        let size2 = CGSize(width: 20, height: 5)
        addItem(title: "constrained", desc: "\(size1.mg.constrained(by: size2))", section: 0)
        addItem(title: "filling", desc: "\(size1.mg.filling(by: size2))", section: 0)
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
            return "Property"
        case 1:
            return "method"
        default:
            return nil
        }
    }
    
    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestSizeViewController {
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
