//
//  MGTableViewCellProtocol.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/5/24.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import Foundation

protocol MGTableViewCellProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: MGTableViewCellProtocol {
    static var identifier: String {
        let name = NSStringFromClass(Self.self)
        if(name.contains(".")){
            return name.components(separatedBy: ".")[1];
        }else{
            return name;
        }
    }
}
