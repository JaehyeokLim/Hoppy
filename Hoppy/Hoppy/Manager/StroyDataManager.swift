//
//  StroyDataManager.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/05.
//

struct StoryTotalJsonData: Codable {
    var status: Int?
    var message: String?
    var data: StoryListInTotalJsonData?
}

struct StoryListInTotalJsonData: Codable {
    var storyList : [StoryDetailDataInList]?
    var lastId: String?
}

struct StoryDetailDataInList: Codable {
    var id: Int?
    var memberId: Int?
    var profileUrl: String?
    var username: String?
    var title: String?
    var filename: String?
    var content: String?
    var liked: Bool?
    var likeCount: Int?
    var replyCount: Int?
    var createdDate: String?
}

import UIKit

class StroyDataManager: UIViewController {
    
    func storyDataLoadInitFunction() {
        StoryDetailDataList.removeAll()
        
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://hoppy.kro.kr/api/story")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
//        request.setValue("Bearer \(TokenList[0].token)", forHTTPHeaderField: "Authorization")
        request.addValue("Bearer \(TokenList[0].token!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            
            print(String(data: data, encoding: .utf8))
            let StoryTotalJsonDataToJson = try? JSONDecoder().decode(StoryTotalJsonData.self, from: data)
            let StoryTotalJsonDataItem = StoryTotalDataModel(status: StoryTotalJsonDataToJson?.status, message: StoryTotalJsonDataToJson?.message)
            
            print(StoryTotalJsonDataItem)
            
            for i in 0..<(StoryTotalJsonDataToJson?.data?.storyList?.count ?? 0){
                let StoryDetailDataItem = StoryDetailDataModel(id: StoryTotalJsonDataToJson?.data?.storyList?[i].id, memberId: StoryTotalJsonDataToJson?.data?.storyList?[i].memberId, profileUrl: StoryTotalJsonDataToJson?.data?.storyList?[i].profileUrl, username: StoryTotalJsonDataToJson?.data?.storyList?[i].username, title: StoryTotalJsonDataToJson?.data?.storyList?[i].title, filename: StoryTotalJsonDataToJson?.data?.storyList?[i].filename, content: StoryTotalJsonDataToJson?.data?.storyList?[i].content, liked: StoryTotalJsonDataToJson?.data?.storyList?[i].liked, likeCount: StoryTotalJsonDataToJson?.data?.storyList?[i].likeCount, replyCount: StoryTotalJsonDataToJson?.data?.storyList?[i].replyCount, createDate: StoryTotalJsonDataToJson?.data?.storyList?[i].createdDate)
                
                StoryDetailDataList.append(StoryDetailDataItem)
            }
                    
            for i in 0..<StoryDetailDataList.count {
                print(StoryDetailDataList[i])
            }
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
