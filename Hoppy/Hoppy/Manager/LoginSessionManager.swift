////
////  LoginSessionManager.swift
////  Hoppy
////
////  Created by Jaehyeok Lim on 2022/10/11.
////
//
//import UIKit
//import KakaoSDKAuth
//import KakaoSDKUser
//import KakaoSDKCommon
//
//class LoginSessionManager: UIViewController {
//    
//    func kakaoUserLoginTotalFunction() {
//        if (AuthApi.hasToken()) {
//            UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
//                if let error = error {
//                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
//                        //로그인 필요
//                        self.kakaoUserLogin()
//                    }
//                    else {
//                        //기타 에러
//                    }
//                }
//                else {
//                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
//                    print("access 토큰 생성: \(String(describing: accessTokenInfo))")
//                    SideMenuViewController().kakaoUserDataLoad()
//                }
//            }
//        }
//        else {
//            //로그인 필요
//            kakaoUserLogin()
//        }
//    }
//    
//    func kakaoUserLogin() {
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    // 예외 처리 (로그인 취소 등)
//                    print(error)
//                    
//                } else {
//                    
//                    print("loginWithKakaoTalk() success.")
//                    SideMenuViewController().kakaoUserDataLoad()
//                    
//                    print("oauth 토큰 생성: \(oauthToken)")
//                }
//            }
//            
//        } else if (!UserApi.isKakaoTalkLoginAvailable()) {
//            
//            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//               if let error = error {
//                   
//                 print(error)
//                   
//               } else {
//                   
//                    print("loginWithKakaoAccount() success.")
//                   SideMenuViewController().kakaoUserDataLoad()
//                   
//                   //do something
//                    print("oauth 토큰 생성: \(oauthToken)")
//                }
//            }
//        }
//    }
//}
