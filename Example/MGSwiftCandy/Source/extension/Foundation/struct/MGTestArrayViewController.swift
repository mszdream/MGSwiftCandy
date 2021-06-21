//
//  MGTestArrayViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/25.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit

class MGTestArrayViewController: MGBaseViewController {
    override func generatingData() {
        var array1 = [1, 2, 3]
        addItem(title: "sum", desc: String(array1.mg.sum()))
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? UITableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        cell.textLabel?.text = "\(model.title)\n\(model.desc)"
        cell.textLabel?.numberOfLines = 0
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
    
    private func addItem(title: String, desc: String) {
        let model = MGListItemModel(title: title, desc: desc)
        super.addDataModel(model: model)
    }
    
    /// The data types in the model must be consistent with those in JSON
    class MGPerson: Decodable, Encodable {
        var id: Int
        var name: String?
    }
}

