//
//  ProfileDataLoadManager.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/12.
//

import UIKit

struct ProfileTotalJsonData: Codable {
    var status: Int?
    var message: String?
    var data: ProfileDetailInfoInData?
}

struct ProfileDetailInfoInData: Codable {
    var id: Int?
    var eamil: String?
    var username: String?
    var profileUrl: String?
    var intro: String?
    var deleted: Bool?
    var myMeetingsId: Array<Int>?
    var likeMeetingsId: Array<Int>?
}

class ProfileDataLoadManager: UIViewController {
    
    func profileDataLoadManagerFunction(token: String) {
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://hoppy.kro.kr/api/profile")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("JSESSIONID=90434AAACDB72682C087462224427918", forHTTPHeaderField: "Cookie")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
              
            return
          }
            let ProfileTotalJsonDataToJson = try? JSONDecoder().decode(ProfileTotalJsonData.self, from: data)
            
            let ProfileDetailInfoInDataItem = ProfileDetailInfoInDataModel(id: ProfileTotalJsonDataToJson?.data?.id, eamil: ProfileTotalJsonDataToJson?.data?.eamil, username: ProfileTotalJsonDataToJson?.data?.username, profileUrl: ProfileTotalJsonDataToJson?.data?.profileUrl, intro: ProfileTotalJsonDataToJson?.data?.intro, deleted: ProfileTotalJsonDataToJson?.data?.deleted, myMeetingsId: ProfileTotalJsonDataToJson?.data?.myMeetingsId, likeMeetingsId: ProfileTotalJsonDataToJson?.data?.likeMeetingsId)
            
            ProfileDetailInfoInDataList.append(ProfileDetailInfoInDataItem)
            
            print("Hoppy Server: Profile Data Load Complete.\n\n")
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}
