//
//  PhotoAuthorityManager.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/11.
//

import UIKit
import Photos

class PhotoAuthorityManager: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkAlbumPermission(){
            PHPhotoLibrary.requestAuthorization( { status in
//                switch status {
//                case .authorized:
//                    print("Album: 권한 허용")
//                    
//                case .denied:
//                    print("Album: 권한 거부")
//                    
//                case .restricted, .notDetermined:
//                    print("Album: 선택하지 않음")
//                    
//                default:
//                    break
//                }
            })
    }
    
    func checkCameraPermission(){
           AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
//               if granted {
//                   print("Camera: 권한 허용")
//
//               } else {
//                   print("Camera: 권한 거부")
//               }
           })
    }
}


