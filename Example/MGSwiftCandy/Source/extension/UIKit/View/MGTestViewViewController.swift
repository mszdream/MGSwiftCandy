//
//  MGTestViewViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/5/31.
//  Copyright © 2021 mszdream. All rights reserved.
//

#if MGSwiftCandy_Extension_UIKit

import UIKit

class MGTestViewViewController: MGBaseViewController {
    override func generatingData() {
        var label1 = UILabel()
        label1.backgroundColor = UIColor.mg.random
        label1.text = "x, y, width, height"
        label1.mg.x = 10
        label1.mg.y = 10
        label1.mg.width = 150
        label1.mg.height = 32
        addItem(v: label1, section: 0)
        
        var label2 = UILabel()
        label2.backgroundColor = UIColor.mg.random
        label2.text = "centerX, centerY"
        label2.mg.width = 150
        label2.mg.height = 32
        label2.mg.centerX = 85
        label2.mg.centerY = 48
        addItem(v: label2, section: 0)
        
        var label3 = UILabel()
        label3.backgroundColor = UIColor.mg.random
        label3.text = "origin, size"
        label3.mg.origin = CGPoint(x: 10, y: 10)
        label3.mg.size = CGSize(width: 150, height: 64)
        addItem(v: label3, section: 0)
        
        let label4 = UILabel()
        label4.frame = CGRect(x: 20, y: 20, width: 100, height: 64)
        label4.text = "渐变背景色"
        label4.mg.gradient(colors: [.green, .red, .blue], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1), mask: false)
        addItem(v: label4, section: 1)
        
        // 渐变色文字：步骤：1、给视图增加一个渐变色的layer，2、将label的layer添加到这个渐变的layer的mask上面
        let view5 = UIView(frame: CGRect(x: 20, y: 20, width: 300, height: 64))
        let layer5 = view5.mg.gradient(colors: [.green, .red], frame: CGRect(x: 0, y: 0, width:300, height: 64), startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1), mask: false)
        let label5 = UILabel()
        label5.frame = CGRect(x: 0, y: 0, width: 300, height: 64)
        label5.textAlignment = .center
        label5.font = UIFont.systemFont(ofSize: 30)
        label5.text = "遮罩实现渐变色"
        view5.addSubview(label5)
        layer5?.mask = label5.layer
        addItem(v: view5, section: 1)
        
        // 画圆角
        let view6 = UIView(frame: CGRect(x: 20, y: 20, width: 64, height: 64))
        view6.backgroundColor = .green
        view6.mg.fillet(radii: CGSize(width: 32, height: 32),
                        rectCorner: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.bottomRight.rawValue),
                        frame: view6.bounds)
        addItem(v: view6, section: 1)
        
        // 渐变色边框
        let label7 = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 64))
        label7.backgroundColor = .yellow
        label7.mg.border(colors: [.green, .red, .blue],
                         width: 10,
                         radii: CGSize(width: 32, height: 32),
                         rectCorner: .allCorners,
                         frame: label7.bounds,
                         startPoint: CGPoint(x: 0, y: 0),
                         endPoint: CGPoint(x: 1, y: 1))
        label7.textAlignment = .center
        label7.text = "渐变色边框"
        addItem(v: label7, section: 1)
        
        // 渐变色边框
        let label8 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 64))
        label8.backgroundColor = .yellow
        label8.textAlignment = .center
        label8.text = "使用 capture 截图"
        let imageView8 = UIImageView(image: label8.mg.capture)
        imageView8.frame = CGRect(x: 20, y: 20, width: 200, height: 64)
        addItem(v: imageView8, section: 1)
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? UITableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.contentView.addSubview(model.view)
    }

    override func title(section: Int) -> String? {
        switch section {
        case 0:
            return "属性"
        case 1:
            return "方法"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MGTestViewViewController {
    class MGListItemModel: MGModelProtocol {
        var view: UIView
        init(view: UIView) {
            self.view = view
        }
    }
    
    private func addItem(v: UIView, section: Int) {
        let model = MGListItemModel(view: v)
        super.addDataModel(model: model, section: section)
    }
    
    
}

#endif
