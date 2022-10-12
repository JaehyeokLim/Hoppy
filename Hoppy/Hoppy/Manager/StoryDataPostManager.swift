//
//  StoryDataPostManager.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/11.
//

import UIKit
//request.setValue("Basic \(encoded)", forHTTPHeaderField: "Authorization")
class StoryDataPostManager: UIViewController {
    
    func storyDataPostFunction(title: String, content: String, token: String) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n  \"title\" : \"\(title)\",\n  \"content\" : \"\(content)\",\n  \"filename\" : \"https://hoppyservice.s3.ap-northeast-2.amazonaws.com/23EA1CB4-4E75-429E-A493-9E2BE8B91395.jpeg1665383682000\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://hoppy.kro.kr/api/story")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
}
