//
//  MGTestButtonViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/6/18.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit

class MGTestButtonViewController: MGBaseViewController {
    override func generatingData() {
        // MARK: - image
        var button1 = UIButton()
        button1.mg.titleForNormal = " titleForNormal \n titleColorForNormal \n numberOfLines \n imageForNormal"
        button1.mg.titleColorForNormal = .black
        button1.mg.numberOfLines = 0
        button1.mg.imageForNormal = UIImage.mg.`init`(color: .yellow, size: CGSize(width: 60, height: 60))
        button1.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button1, section: 0)
        
        var button2 = UIButton()
        button2.mg.titleForHighlighted = " titleForHighlighted \n titleColorForHighlighted \n imageForHighlighted"
        button2.mg.titleColorForHighlighted = .red
        button2.mg.imageForHighlighted = UIImage.mg.`init`(color: .green, size: CGSize(width: 60, height: 60))
        button2.isHighlighted = true
        button2.mg.numberOfLines = 0
        button2.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button2, section: 0)
        
        var button3 = UIButton()
        button3.mg.titleForSelected = " titleForSelected \n titleColorForSelected \n imageForSelected"
        button3.mg.titleColorForSelected = .red
        button3.mg.imageForSelected = UIImage.mg.`init`(color: .red, size: CGSize(width: 60, height: 60))
        button3.isSelected = true
        button3.mg.numberOfLines = 0
        button3.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button3, section: 0)
        
        var button4 = UIButton()
        button4.mg.titleForDisabled = " titleForDisabled \n titleColorForDisabled \n imageForDisabled"
        button4.mg.titleColorForDisabled = .red
        button4.mg.imageForDisabled = UIImage.mg.`init`(color: .gray, size: CGSize(width: 60, height: 60))
        button4.isEnabled = false
        button4.mg.numberOfLines = 0
        button4.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button4, section: 0)
        
        // MARK: - background image
        var button5 = UIButton()
        button5.mg.titleForNormal = "backgroundImageForNormal"
        button5.mg.backgroundImageForNormal = UIImage.mg.`init`(color: .red, size: CGSize(width: 60, height: 60))
        button5.mg.numberOfLines = 0
        button5.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button5, section: 1)
        
        var button6 = UIButton()
        button6.mg.titleForNormal = "backgroundImageForHighlighted"
        button6.mg.backgroundImageForHighlighted = UIImage.mg.`init`(color: .red, size: CGSize(width: 60, height: 60))
        button6.isHighlighted = true
        button6.mg.numberOfLines = 0
        button6.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button6, section: 1)
        
        var button7 = UIButton()
        button7.mg.titleForNormal = "backgroundImageForSelected"
        button7.mg.backgroundImageForSelected = UIImage.mg.`init`(color: .red, size: CGSize(width: 60, height: 60))
        button7.isSelected = true
        button7.mg.numberOfLines = 0
        button7.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button7, section: 1)
        
        var button8 = UIButton()
        button8.mg.titleForNormal = "backgroundImageForDisabled"
        button8.mg.backgroundImageForDisabled = UIImage.mg.`init`(color: .red, size: CGSize(width: 60, height: 60))
        button8.isEnabled = false
        button8.mg.numberOfLines = 0
        button8.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button8, section: 1)
        
        // MARK: - background color
        var button9 = UIButton()
        button9.mg.titleForNormal = "backgroundColorForNormal"
        button9.mg.backgroundColorForNormal = .green
        button9.mg.numberOfLines = 0
        button9.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button9, section: 2)
        
        var button10 = UIButton()
        button10.mg.titleForNormal = "backgroundColorForHighlighted"
        button10.mg.backgroundColorForHighlighted = .green
        button10.mg.numberOfLines = 0
        button10.isHighlighted = true
        button10.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button10, section: 2)
        
        var button11 = UIButton()
        button11.mg.titleForNormal = "backgroundColorForSelected"
        button11.mg.backgroundColorForSelected = .green
        button11.mg.numberOfLines = 0
        button11.isSelected = true
        button11.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button11, section: 2)
        
        var button12 = UIButton()
        button12.mg.titleForNormal = "backgroundColorForDisabled"
        button12.mg.backgroundColorForDisabled = .green
        button12.mg.numberOfLines = 0
        button12.isEnabled = false
        button12.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button12, section: 2)
        
        var button13 = UIButton()
        button13.mg.titleForNormal = "backgroundColor"
        button13.mg.backgroundColor = .green
        button13.mg.numberOfLines = 0
        button13.frame = CGRect(x: 10, y: 10, width: 300, height: 80)
        addItem(button: button13, section: 2)
        
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? UITableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.contentView.addSubview(model.button)
    }

    override func title(section: Int) -> String? {
        switch section {
        case 0:
            return "title"
        case 1:
            return "background image"
        case 2:
            return "background color"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MGTestButtonViewController {
    class MGListItemModel: MGModelProtocol {
        var button: UIButton
        init(button: UIButton) {
            self.button = button
        }
    }
    
    private func addItem(button: UIButton, section: Int) {
        let model = MGListItemModel(button: button)
        super.addDataModel(model: model, section: section)
    }
    
    
}
