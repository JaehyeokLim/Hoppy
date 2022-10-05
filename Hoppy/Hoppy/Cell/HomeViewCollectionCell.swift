//
//  HomeViewCollectionCell.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/09/03.
//

import UIKit

class HomeViewCollectionCell: UICollectionViewCell {
    static let identifier = "UserViewCustomCell"

    let userViewImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    let userViewTitle: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.homeViewCommonTextColor
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private func setConstraint() {
        contentView.backgroundColor = UIColor.contentViewBackgroundColor
        
        addSubview(userViewImage)
        addSubview(userViewTitle)
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowRadius = 2
//        layer.shadowOffset = CGSize(width: 10, height: 10)

        contentView.layer.borderWidth = 0.7
        contentView.layer.borderColor = UIColor.hobbyCellBorderColor?.cgColor
        contentView.layer.cornerRadius = 15
        
        userViewImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        userViewTitle.snp.makeConstraints { make in
            make.top.equalTo(userViewImage.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(42.5)
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
