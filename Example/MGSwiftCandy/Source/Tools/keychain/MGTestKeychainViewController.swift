//
//  MGTestKeychainViewController.swift
//  MGSwiftCandy_Example
//
//  Created by msz on 2021/6/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MGSwiftCandy

class MGTestKeychainViewController: MGBaseViewController {
    let kService = "com.mg.keychain"
    let kUserKey = "user"
    let kUserValue = "zhang san"
    let kPasswordKey = "password"
    let kPasswrodVaalue = "123456"
    let kAgeKey = "age"
    let kAgeValue = "20"
    let kAccessGroup = "accessGroup"
    
    override func generatingData() {
        // MAKE: - String value
        MGKeychain.mg.setPassword(service: kService, account: kUserKey, password: kUserValue, accessGroup: kAccessGroup)
        MGKeychain.mg.setPassword(service: kService, account: kPasswordKey, password: kPasswrodVaalue, accessGroup: kAccessGroup)
        MGKeychain.mg.setPassword(service: kService, account: kAgeKey, password: kAgeValue, accessGroup: kAccessGroup)
        addItem(title: "setPassword", desc: "\(kUserKey) = \(kUserValue); \(kPasswordKey) = \(kPasswrodVaalue); \(kAgeKey) = \(kAgeValue)", section: 0)
        
        if let user: String = MGKeychain.mg.getPassword(service: kService, account: kUserKey, accessGroup: kAccessGroup) {
            addItem(title: "getPassword", desc: "\(kUserKey) = \(user.description)", section: 0)
        }

        MGKeychain.mg.remove(service: kService, account: kUserKey, accessGroup: kAccessGroup)
        addItem(title: "remove", desc: "\(kUserKey) = \(kUserValue)", section: 0)


        // MARK: - Codable object value
        let obj1 = MGKeychainStoredModel(name: "zhang san", age: 20)
        MGKeychain.mg.setPassword(account: kUserValue, password: obj1)
        addItem(title: "setPassword", desc: "\(obj1.description)", section: 1)

        if let obj: MGKeychainStoredModel = MGKeychain.mg.getPassword(account: kUserValue) {
            addItem(title: "getPassword", desc: "\(obj.description)", section: 1)
        }
        
        // MARK: - AllPasswords
        let valueForAllCounts_StringType: [String] = MGKeychain.mg.allPasswords()
        addItem(title: "allPasswords(All values of String type)", desc: "\(valueForAllCounts_StringType)", section: 2)
        
        let valueForAllCounts_MGKeychainStoredModelType: [MGKeychainStoredModel] = MGKeychain.mg.allPasswords()
        addItem(title: "allPasswords(All values of MGKeychainStoredModel type)", desc: "\(valueForAllCounts_MGKeychainStoredModelType)", section: 2)
        
        let valueForService: [String] = MGKeychain.mg.allPasswords(service: kService, accessGroup: nil)
        addItem(title: "allPasswords(specific service)", desc: "\(valueForService)", section: 2)
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
            return "String Value"
        case 1:
            return "Object Value"
        case 2:
            return "AllPasswords"
        default:
            return nil
        }
    }
    
    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestKeychainViewController {
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

extension MGTestKeychainViewController {
    struct MGKeychainStoredModel: Codable {
        var name = ""
        var age = 0
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        var description: String {
            return "name = \(name), age = \(age)" as String
        }
    }
}
