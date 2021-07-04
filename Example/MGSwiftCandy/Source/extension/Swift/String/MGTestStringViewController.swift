//
//  MGTestStringViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/6/16.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit

class MGTestStringViewController: MGBaseViewController {
    override func generatingData() {
        addItem(title: "md5", desc: "hello".mg.md5)
        addItem(title: "length", desc: "\("hello".mg.length)")
        addItem(title: "isNotEmpty", desc: "\("hello".mg.isNotEmpty)")
        addItem(title: "uppercasedAtSentenceBoundary", desc: "hello. baby".mg.uppercasedAtSentenceBoundary)
        addItem(title: "base64Encoded", desc: "hello".mg.base64Encoded!)
        addItem(title: "base64Decoded", desc: "aGVsbG8=".mg.base64Decoded!)
        addItem(title: "unicodeEncoded", desc: "哈喽".mg.unicodeEncoded)
        addItem(title: "unicodeDecoded", desc: "\\u54c8\\u55bd".mg.unicodeDecoded!)
        
        addItem(title: "URLEncodedString", desc: "https://www.哈喽.com?a=1&b=2".mg.urlEncodedString)
        addItem(title: "URLDecodedString", desc: "https://www.%E5%93%88%E5%96%BD.com?a=1&b=2".mg.urlDecodedString)
        addItem(title: "urlEncoded", desc: "https://www.哈喽.com?a=1&b=2".mg.urlEncoded)
        addItem(title: "urlDecoded", desc: "https%3A%2F%2Fwww.%E5%93%88%E5%96%BD.com%3Fa=1&b=2".mg.urlDecoded)
        addItem(title: "charactersArray", desc: "\("hello".mg.charactersArray)")
        addItem(title: "camelCased", desc: "hEllo class method".mg.camelCased)
        addItem(title: "containEmoji", desc: "\("k😀k".mg.containEmoji)")
        addItem(title: "firstCharacterAsString", desc: "hello".mg.firstCharacterAsString ?? "")
        addItem(title: "lastCharacterAsString", desc: "hello".mg.lastCharacterAsString ?? "")
        addItem(title: "hasLetters", desc: "\("123".mg.hasLetters)")
        addItem(title: "hasNumbers", desc: "\("A1A".mg.hasNumbers)")
        addItem(title: "isAlphabetic", desc: "\("A1A".mg.isAlphabetic)")
        addItem(title: "isAlphaNumeric", desc: "\("123abc".mg.isAlphaNumeric)")
        addItem(title: "isEmail", desc: "\("hello@126.com".mg.isEmail)")
        addItem(title: "isValidUrl", desc: "\("http://hello.com".mg.isValidUrl)")
        addItem(title: "isValidSchemedUrl", desc: "\("https://hello.com".mg.isValidSchemedUrl)")
        addItem(title: "isValidHttpsUrl", desc: "\("https://hello.com".mg.isValidHttpsUrl)")
        addItem(title: "isValidHttpUrl", desc: "\("https://hello.com".mg.isValidHttpUrl)")
        addItem(title: "isValidFileUrl", desc: "\("file://hello.txt".mg.isValidFileUrl)")
        addItem(title: "isNumeric", desc: "\("123".mg.isNumeric)")
        addItem(title: "latinized", desc: "\("Hèllö Wórld!".mg.latinized)")
        addItem(title: "date", desc: "\(String(describing: "2007-06-29".mg.date))")
        addItem(title: "dateTime", desc: "\(String(describing: "2007-06-29 14:23:09".mg.dateTime))")
        addItem(title: "bool", desc: "\(String(describing: "False".mg.bool))")
        addItem(title: "int", desc: "\(String(describing: "88".mg.int))")
        addItem(title: "float", desc: "\(String(describing: "88.88".mg.float))")
        addItem(title: "double", desc: "\(String(describing: "88.88".mg.double))")
        addItem(title: "url", desc: "\(String(describing: "https://hello.com".mg.url))")
        addItem(title: "trim", desc: "\(" hello  ")")
        addItem(title: "withoutSpacesAndNewLines", desc: "\("   \n Swifter   \n  Swift  ".mg.withoutSpacesAndNewLines)")
        addItem(title: "isWhitespace", desc: "\(" \n \t".mg.isWhitespace)")
        addItem(title: "countLowercasedCharacters", desc: "\("HellO".mg.countLowercasedCharacters)")
        addItem(title: "countUppercasedCharacters", desc: "\("HellO".mg.countUppercasedCharacters)")
        addItem(title: "countNumbers", desc: "\("HellO520".mg.countNumbers)")
        addItem(title: "countSymbols", desc: "\("HellO+&520".mg.countSymbols)")
        addItem(title: "stringFromHEX", desc: "68 65 6c 6c 6f".mg.stringFromHEX)
        
        addItem(title: "substring", desc: "hello".mg.substring(from: 1))
        addItem(title: "substring", desc: "hello".mg.substring(to: 3))
        addItem(title: "substring", desc: "hello".mg.substring(with: 1...3))
        
        addItem(title: "removeExtraSpaces", desc: "a aa  aaa   b".mg.removeExtraSpaces())
        addItem(title: "replacingOccurrences", desc: "abcdefg".mg.replacingOccurrences(of: ["a", "de"], with: ""))
        addItem(title: "matches", desc: "\("hello baby".mg.matches(pattern: "e"))")
        addItem(title: "paddingStart", desc: "hello".mg.paddingStart(10, with: "a"))
        addItem(title: "paddingEnd", desc: "hello".mg.paddingEnd(10, with: "a"))
        
        addItem(title: "toAttributedString", desc: "", attrDesc:  "hello".mg.toAttributedString(UIFont.systemFont(ofSize: 17), .red, nil))
        addItem(title: "getAttributedStringSize", desc: "\("hello".mg.getAttributedStringSize())")
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

extension MGTestStringViewController {
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
