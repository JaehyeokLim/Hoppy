////
////  JsonDataManager.swift
////  Hoppy
////
////  Created by Jaehyeok Lim on 2022/09/20.
////
//
//import UIKit
//
//struct GetPresighnedURL: Codable {
//    var message : String
//    var status: Int
//    var data: Array<String>
//}
//
//
//class JsonDataManager: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    func seqPostBoxStatusGet() {
//        let semaphore = DispatchSemaphore (value: 0)
//
////        let parameters = "}"
////        let postData = parameters.data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: "https://hoppy.kro.kr/api/health")!,timeoutInterval: Double.infinity)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        request.httpMethod = "GET"
////        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            semaphore.signal()
//            return
//          }
//            if let info = try? JSONDecoder().decode(GetPresighnedURL.self, from: data) {
//                print(info.status)
//                print(info.message)
//                print(info.data)
//                print(String(data: data, encoding: .utf8)!)
//                
//                semaphore.signal()
//            }
//        }
//
//        task.resume()
//        semaphore.wait()
//    }
    
//    func seqPostBoxStatusGet2() {
//        var semaphore = DispatchSemaphore (value: 0)
//
////        let parameters = "}"
////        let postData = parameters.data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: "https://hoppy.kro.kr/api/health")!,timeoutInterval: Double.infinity)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        request.httpMethod = "GET"
////        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            semaphore.signal()
//            return
//          }
//            if let info = try? JSONDecoder().decode(GetPresighnedURL.self, from: data) {
//                print(info.status)
//                print(info.message)
//                print(info.data)
//                print(String(data: data, encoding: .utf8)!)
//
//                semaphore.signal()
//            }
//        }
//
//        task.resume()
//        semaphore.wait()
//    }
//}

