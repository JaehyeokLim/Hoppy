//
//  SideMenuViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/09/03.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKTalk

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
    
    private let userProfileName: UILabel = {
        let label = UILabel()
        
        label.text = "로그인을 해주세요!"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let userProfileSubLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Hoppy에 오신걸 환영합니다!"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.isHidden = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if items[0] == "로그인" {
//            kakaoUserLoginTotalFunction()
        } else {
            print("이미 로그인이 되어있습니다")
        }
    }
    
    private func SideMenuViewLayout() {
        view.backgroundColor = UIColor.scrollViewbackgroundColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        superViewList = [sideMenuHobbyLogoImageView, tableView, userProfileName, userProfileSubLabel]
        
        for listName in superViewList {
            view.addSubview(listName)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(335)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        sideMenuHobbyLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(170)
            make.leading.equalTo(view).offset(48)
            make.size.equalTo(CGSize(width: 150, height: 80))
        }
        
        userProfileName.snp.makeConstraints { make in
            make.top.equalTo(sideMenuHobbyLogoImageView.snp.bottom).offset(15)
            make.width.equalTo(view)
        }
        
        userProfileSubLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileName.snp.bottom).offset(5)
            make.width.equalTo(view)
        }
    }
    
    @objc func onKakaoLoginByAppTouched() {
        if items[0] == "로그인" {
            kakaoUserLoginTotalFunction()
        } else {
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("logout() success.")
                    
                    self.userProfileName.text = "로그인을 해주세요!"
                    self.userProfileName.font = UIFont.systemFont(ofSize: 18)
                    self.userProfileSubLabel.isHidden = true
                    self.items = ["로그인", "마이페이지", "회원탈퇴"]
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func kakaoUserLoginTotalFunction() {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        self.kakaoUserLogin()
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    self.kakaoUserDataLoad()
                }
            }
        }
        else {
            //로그인 필요
            kakaoUserLogin()
        }
    }
    
    func kakaoUserLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                    
                } else {
                    
                    print("loginWithKakaoTalk() success.")
                    self.kakaoUserDataLoad()

                }
            }
            
        } else if (!UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
               if let error = error {
                   
                 print(error)
                   
               } else {
                   
                    print("loginWithKakaoAccount() success.")
                    self.kakaoUserDataLoad()
 
                }
            }
        }
    }
    
    func kakaoUserDataLoad() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                //do something
                let info = user
                print(info!)
                
                if let id = user?.id {
                    if let name = user?.kakaoAccount?.profile?.nickname {
                        if let mail = user?.kakaoAccount?.email {
                            if let profile = user?.kakaoAccount?.profile?.thumbnailImageUrl {
                                self.userProfileName.text = name + "\n님"
                                self.userProfileName.font = UIFont.boldSystemFont(ofSize: 18)
                                self.userProfileSubLabel.isHidden = false
                                self.items = ["로그아웃", "마이페이지", "회원탈퇴"]
                                
                                let profileUrl = profile.absoluteString
                                
                                print("id: \(id)\n이름: \(name)\n이메일: \(mail)\n프로필: \(profileUrl)")
                                
                                LoginDataManager().loginDataManagerFunction(id: Int(id), email: mail, profileUrl: profileUrl)
                                
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuViewTableCell", for: indexPath) as! SideMenuViewTableCell
        
//        cell.sideMenuItem.text = items[indexPath.row]
        cell.sideMenuItem.setTitle(items[indexPath.row], for: .normal)
        
        return cell
    }
}
