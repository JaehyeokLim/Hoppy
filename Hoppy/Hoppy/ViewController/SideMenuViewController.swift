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
                    print("access 토큰 생성: \(String(describing: accessTokenInfo))")
                    self.kakaoUserDataLoad()
                }
            }
        }
        else {
            //로그인 필요
            kakaoUserLogin()
        }
    }
    
    func kakaoUserTokenCheck() {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                }
            }
        }
        else {
            //로그인 필요
        }
    }
    
    func kakaoUserLogin() {
        if (!UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                    
                } else {
                    
                    print("loginWithKakaoTalk() success.")
                    print("oauth 토큰 생성: \(oauthToken)")
                }
            }
            
        } else {
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
               if let error = error {
                   
                 print(error)
                   
               } else {
                   
                    print("loginWithKakaoAccount() success.")
                    self.kakaoUserDataLoad()
                   
                   //do something
                    print("oauth 토큰 생성: \(oauthToken)")
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
                print("사용자 정보 가져오기 성공")
                
                if let name = user?.kakaoAccount?.profile?.nickname {
                    if let mail = user?.kakaoAccount?.email {
                        if let gender = user?.kakaoAccount?.gender {
                            if let ageRange = user?.kakaoAccount?.ageRange {
                                if let birthday = user?.kakaoAccount?.ageRange {
                                    self.userProfileName.text = name + "\n님"
                                    self.userProfileName.font = UIFont.boldSystemFont(ofSize: 18)
                                    self.userProfileSubLabel.isHidden = false
                                    self.items = ["로그아웃", "마이페이지", "회원탈퇴"]
                                    
                                    print("이름: \(name)\n이메일: \(mail)\n성별: \(gender)\n연령대: \(ageRange)\n생년월일: \(birthday)")
                                    self.tableView.reloadData()
                                }
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
