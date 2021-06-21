//
//  MGTestScreenViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/6/18.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit

class MGTestScreenViewController: MGBaseViewController {
    override func generatingData() {
        addItem(title: "width", desc: "\(UIScreen.mg.width)")
        addItem(title: "height", desc: "\(UIScreen.mg.height)")
        addItem(title: "scale", desc: "\(UIScreen.mg.scale)")
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? MGTableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.desc
    }

    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestScreenViewController {
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
    
    private func addItem(title: String, desc: String) {
        let model = MGListItemModel(title: title, desc: desc)
        super.addDataModel(model: model)
    }
}
