//
//  MGModelProtocol.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/24.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import Foundation

protocol MGModelProtocol {
    var title: String { get }
}

extension MGModelProtocol {
    var title: String {
        return ""
    }
}

extension UITableViewCell: MGModelProtocol {}
