//
//  MGTestEventerViewController.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/6/20.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import SnapKit
import MGSwiftCandy

class MGTestEventerViewController: UIViewController {
    private var textLabel = UILabel()
    private var button = UIButton(type: .custom)
    private let kCurrentTime = "current time"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(textLabel)
        self.view.addSubview(button)
        
        textLabel.backgroundColor = .yellow
        textLabel.textColor = .red
        textLabel.textAlignment = .center
        
        button.mg.titleForNormal = "获取当前时间"
        button.mg.titleColorForNormal = .black
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        MGEventer.mg.subscribe(self, name: kCurrentTime) { notice in
            self.textLabel.text = notice.userInfo?["time"] as? String
        }
        
        textLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(100)
            make.right.equalTo(-10)
            make.height.equalTo(100)
        }
        
        button.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.right.equalTo(-10)
            make.height.equalTo(48)
        }
        
    }
    
    @objc func buttonClicked(sender: UIButton) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
        let time = dateformatter.string(from: Date())
        
        MGEventer.mg.post(kCurrentTime, on: .global(), object: self, userInfo: ["time": time])
    }
    
}
