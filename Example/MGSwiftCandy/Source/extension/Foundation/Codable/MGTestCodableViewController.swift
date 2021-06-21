//
//  MGTestCodableViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/24.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit

class MGTestCodableViewController: MGBaseViewController {
    override func generatingData() {
        let string = "{\"id\": 1, \"name\": \"zhang san\"}"
        let person = MGPerson.decode(from: string)
        addItem(title: "json to model", desc: person.debugDescription)
        
        let jsonly = person?.jsonify
        addItem(title: "model to json", desc: jsonly!)
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

extension MGTestCodableViewController {
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
