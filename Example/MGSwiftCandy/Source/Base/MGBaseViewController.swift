//
//  BaseViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/24.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import MGSwiftCandy

class MGBaseViewController: UIViewController, MGTableViewControllerProtocol {
    private let mainTableView = UITableView(frame: .zero)
    
    private var dataSource: [[MGModelProtocol]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        mainTableView.frame = self.view.bounds
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 60
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.register(cellType, forCellReuseIdentifier: cellType.identifier)
        
        self.view.addSubview(mainTableView)
        
        generatingData()
    }
    
    // MARK: - MGTableViewControllerProtocol
    var cellType: UITableViewCell.Type {
        return UITableViewCell.self
    }
    
    func generatingData() {
        mainTableView.reloadData()
    }
    
    func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        
    }
    
    func title(section: Int) -> String? {
        return nil
    }
    
    func cellClicked(model: MGModelProtocol) {
        
    }
    
    func addDataModel(model: MGModelProtocol, section: Int = 0) {
        if section < 0 || section > dataSource.count {
            assert(false, "vinvalid section index")
        } else if section == dataSource.count {
            dataSource.append([model])
        } else {
            var dataArray = dataSource[section]
            dataArray.append(model)
            dataSource[section] = dataArray
        }
    }
}

extension MGBaseViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.section][indexPath.row]
        cellClicked(model: model)
    }
}

extension MGBaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        let model = dataSource[indexPath.section][indexPath.row]
        bindModel(cell: cell, model: model)
        
        return cell
    }
    
}

