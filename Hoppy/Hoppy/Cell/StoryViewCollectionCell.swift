//
//  StoryViewCollectionCell.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/06.
//

import UIKit
import SnapKit

class StoryViewCollectionCell: UICollectionViewCell {
    static let identifier = "StoryViewCollectionCell"
    
    var cellList: [UIView] = []
    
    let storyCellProfileImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    let storyCellUsername: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14.5)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let storyCellCreatedDate: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let storyCellTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let storyCellMainTextLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let storyCellHorizonLine: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.layer.borderWidth = 1
        label.backgroundColor = UIColor.hobbyCellBackgroundColor
        label.layer.borderColor = UIColor.hobbyCellBackgroundColor?.cgColor
        
        return label
    }()
    
    let storyCellMainImage: UIImageView = {
        let imageView = UIImageView()
        
        
        
        return imageView
    }()
    
    private func setConstraint() {
        contentView.backgroundColor = UIColor.contentViewBackgroundColor
        
        cellList = [storyCellProfileImage, storyCellUsername, storyCellCreatedDate, storyCellTitleLabel, storyCellMainTextLabel, storyCellHorizonLine, storyCellMainImage]
        
        for uiView in cellList {
            contentView.addSubview(uiView)
        }
        
        storyCellProfileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(6)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        storyCellUsername.snp.makeConstraints { make in
            make.top.equalTo(storyCellProfileImage).offset(9.5)
            make.leading.equalTo(storyCellProfileImage.snp.trailing).offset(10)
        }
        
        storyCellCreatedDate.snp.makeConstraints { make in
            make.top.equalTo(storyCellUsername).offset(2)
            make.trailing.equalTo(contentView).offset(-6)
        }
        
        storyCellTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(storyCellProfileImage.snp.bottom).offset(15)
            make.leading.equalTo(storyCellProfileImage)
        }
        
        storyCellMainTextLabel.snp.makeConstraints { make in
            make.top.equalTo(storyCellTitleLabel.snp.bottom).offset(15)
            make.leading.equalTo(storyCellProfileImage)
        }
        
        storyCellMainImage.snp.makeConstraints { make in
            make.top.equalTo(storyCellMainTextLabel).offset(20)
            make.leading.equalTo(contentView).offset(6)
            make.trailing.equalTo(contentView).offset(-6)
            make.height.equalTo(350)
        }
        
        storyCellHorizonLine.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView).offset(6)
            make.trailing.equalTo(contentView).offset(-6)
            make.height.equalTo(5)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
