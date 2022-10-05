//
//  SideMenuViewTableCell.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/09/03.
//

import UIKit
import SnapKit

class SideMenuViewTableCell: UITableViewCell {
    let identifier = "SideMenuViewTableCell"
    
    let sideMenuItem: UIButton = {
        let button = UIButton()
        
//        label.text = "미정"
//        label.textColor = UIColor.darkGray
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textAlignment = .center
        button.setTitle("test", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    func setConstraint() {
        contentView.backgroundColor = UIColor.scrollViewbackgroundColor
        contentView.addSubview(sideMenuItem)
        
        sideMenuItem.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(contentView)
            make.width.equalTo(contentView)
        }
        
        sideMenuItem.addTarget(SideMenuViewController(), action: #selector(SideMenuViewController().onKakaoLoginByAppTouched), for: .touchUpInside)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
