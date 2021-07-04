//
//  MGTestColorViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/5/23.
//  Copyright © 2021 mszdream. All rights reserved.
//

#if MGSwiftCandy_Extension_UIKit

import UIKit

class MGTestColorViewController: MGBaseViewController {
    override func generatingData() {
        addItem(title: "随机色", color: UIColor.mg.random)
        
        let color = UIColor.green
        let rgbComponents = color.mg.rgbComponents
        addItem(title: "components: \(rgbComponents)", color: color)
        
        let rgbaComponents = color.mg.rgbaComponents
        addItem(title: "components: \(rgbaComponents)", color: color)
        
        let rgbFloatComponents = color.mg.rgbFloatComponents
        addItem(title: "components: \(rgbFloatComponents)", color: color)
        
        let hsbaComponents = color.mg.hsbaComponents
        addItem(title: "hsbaComponents: \(hsbaComponents)", color: color)
        
        let hexString = color.mg.hexString
        addItem(title: "hexString: \(hexString)", color: color)
        
        let shortHexString = color.mg.shortHexString
        addItem(title: "shortHexString: \(String(describing: shortHexString))", color: color)
        
        let shortHexOrHexString = color.mg.shortHexOrHexString
        addItem(title: "shortHexOrHexString: \(shortHexOrHexString)", color: color)
        
        let alpha = color.mg.alpha
        addItem(title: "alpha: \(alpha)", color: color)
        
        let uInt = color.mg.uInt
        addItem(title: "uInt: \(uInt)", color: color)
        
        let complementary = color.mg.complementary
        addItem(title: "complementary: \(String(describing: complementary))", color: complementary!)
        
        // MARK: - 创建
        let rgbtColor = UIColor.mg.`init`(red: 255, green: 255, blue: 0, transparency: 0.1)
        addItem(title: "init", color: rgbtColor!)
        
        let hexIntAlphaColor = UIColor.mg.`init`(hexValue: 0xFF00FF, transparency: 0.1)
        addItem(title: "init", color: hexIntAlphaColor!)
        
        let hexStringAlphaColor = UIColor.mg.`init`(hexString: "#00FF00", transparency: 0.1)
        addItem(title: "init", color: hexStringAlphaColor!)
        
        let complementaryColor = UIColor.mg.`init`(complementaryFor: complementary!)
        addItem(title: "init", color: complementaryColor!)
        
        let rrggbb = UIColor.mg.`init`(hexString: "#0000FF", mode: .rrggbb)
        addItem(title: "init", color: rrggbb!)
        
        addItem(title: "\(rrggbb!.mg.hexRepresentation())", color: rrggbb!)
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? UITableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        cell.textLabel?.text = model.title
        cell.backgroundColor = model.color
        cell.textLabel?.numberOfLines = 0
    }

}

extension MGTestColorViewController {
    class MGListItemModel: MGModelProtocol {
        var title: String = ""
        var color: UIColor = .clear
        init(title: String, color: UIColor) {
            self.title = title
            self.color = color
        }
    }
    
    private func addItem(title: String, color: UIColor) {
        let model = MGListItemModel(title: title, color: color)
        super.addDataModel(model: model)
    }
}

#endif
