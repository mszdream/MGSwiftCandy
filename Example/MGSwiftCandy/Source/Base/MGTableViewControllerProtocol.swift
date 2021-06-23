//
//  MGTableViewControllerProtocol.swift
//  MGSwiftCandy_Example
//
//  Created by mszdream on 2021/5/24.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import Foundation

protocol MGTableViewControllerProtocol {
    /// Get the cell class type
    var cellType: UITableViewCell.Type { get }
    
    /// Generating data
    func generatingData()
    /// Binding the data to model
    func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol)
    /// Get section header title
    func title(section: Int) -> String?
    /// Add data model
    func addDataModel(model: MGModelProtocol, section: Int)
    /// clicked cell
    func cellClicked(model: MGModelProtocol)
}

extension MGTableViewControllerProtocol {
    func title(section: Int) -> String? {
        return nil
    }
}
