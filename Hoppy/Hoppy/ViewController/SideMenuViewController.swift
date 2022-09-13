//
//  SideMenuViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/09/03.
//

import UIKit

class SideMenuViewController: UIViewController {
    var items = ["로그인", "마이페이지", "회원탈퇴"]
    var superViewList: [UIView] = []
    
    private let sideMenuHobbyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "HoppyLogoImage")
        
        return imageView
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        table.backgroundColor = UIColor.scrollViewbackgroundColor
        table.register(SideMenuViewTableCell.self, forCellReuseIdentifier: "SideMenuViewTableCell")
        table.rowHeight = 60
        table.separatorInset.left = 0
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuViewLayout()
    }
    
    private func SideMenuViewLayout() {
        view.backgroundColor = UIColor.scrollViewbackgroundColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        superViewList = [sideMenuHobbyLogoImageView, tableView]
        
        for listName in superViewList {
            view.addSubview(listName)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(250)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        sideMenuHobbyLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(170)
            make.leading.equalTo(view).offset(48)
            make.size.equalTo(CGSize(width: 150, height: 80))
        }
    }
    
//    func kakaoLoginFucntion() {
//        // isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            
//            //카톡 설치되어있으면 -> 카톡으로 로그인
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("카카오 톡으로 로그인 성공")
//                    
//                    _ = oauthToken
//                    /// 로그인 관련 메소드 추가
//                }
//            }
//        } else {
//
//            // 카톡 없으면 -> 계정으로 로그인
//            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("카카오 계정으로 로그인 성공")
//                    
//                    _ = oauthToken
//                    // 관련 메소드 추가
//                }
//            }
//        }
//    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuViewTableCell", for: indexPath) as! SideMenuViewTableCell
        
        cell.sideMenuItem.text = items[indexPath.row]
        
        return cell
    }
    
}
