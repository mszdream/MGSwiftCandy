//
//  MGTestImageViewController.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/23.
//  Copyright © 2021 mszdream. All rights reserved.
//

import UIKit
import SnapKit

class MGTestImageViewController: MGBaseViewController {
    override func generatingData() {
        let redImage = UIImage.mg.`init`(color: .red, size: CGSize(width: 32, height: 32))
        addItem(title: "`init`(color...)", image: redImage!)
        
        let image = UIImage(named: "image")
        let imageColor = image?.mg.color(x: 100, y: 100)
        addItem(title: "color", color: imageColor!)
        
        let blurImage = image?.mg.blurImage()
        addItem(title: "blurImage", image: blurImage!)
        
        let resizeImage = image?.mg.reSizeImage(reSize: CGSize(width: 100, height: 100))
        let resizeTitle = "reSizeImage \n\(String(describing: resizeImage?.size))"
        addItem(title: resizeTitle, image: resizeImage!)
        
        let scaleImage = image?.mg.scaleImage(scaleSize: 0.15)
        let scaleTitle = "scaleImage(scaleSize) \n\(String(describing: scaleImage?.size))"
        addItem(title: scaleTitle, image: scaleImage!)
        
        if let base64 = image?.mg.base64EncodedString,
           let image = UIImage.mg.`init`(base64: base64) {
            addItem(title: "`init`(base64) \n\(base64)", image: image)
        }
        
        let compressedImage: UIImage? = image?.mg.compressed(quality: 0.5)
        addItem(title: "compress \n\(String(describing: image?.size))", image: compressedImage!)
        
        super.generatingData()
    }
    
    override func bindModel(cell: MGTableViewCellProtocol, model: MGModelProtocol) {
        guard let cell = cell as? MGTableViewCell,
              let model = model as? MGListItemModel else {
            return
        }
        
        cell.titleLabel.numberOfLines = 10
        cell.titleLabel.text = model.title
        cell.thumbImageView.image = model.image
        cell.backgroundColor = model.color
    }

    override var cellType: UITableViewCell.Type {
        return MGTableViewCell.self
    }
}

extension MGTestImageViewController {

    class MGListItemModel: MGModelProtocol {
        var title: String = ""
        var color: UIColor = .clear
        var image: UIImage = UIImage()
        init(title: String, image: UIImage, color: UIColor = .clear) {
            self.title = title
            self.image = image
            self.color = color
        }
    }
    
    class MGTableViewCell: UITableViewCell {
        var containerView = UIView()
        var thumbImageView = UIImageView()
        var titleLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.contentView.addSubview(containerView)
            containerView.addSubview(thumbImageView)
            containerView.addSubview(titleLabel)
            
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            thumbImageView.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.width.height.equalTo(100)
                make.centerY.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(thumbImageView.snp.right).offset(10)
                make.right.equalToSuperview().offset(-10)
                make.top.bottom.equalToSuperview()
                make.height.greaterThanOrEqualTo(thumbImageView.snp.height)
            }
            
//            self.contentView.snp.makeConstraints { make in
//                make.edges.equalToSuperview()
//                make.height.greaterThanOrEqualTo(thumbImageView)
//            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    private func addItem(title: String, image: UIImage = UIImage(), color: UIColor = .clear) {
        let model = MGListItemModel(title: title, image: image, color: color)
        super.addDataModel(model: model)
    }
    
}
