//
//  ProfileModel.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/12.
//

import UIKit

var ProfileDetailInfoInDataList = [ProfileDetailInfoInDataModel]()

struct ProfileDetailInfoInDataModel {
    let id: Int?
    let eamil: String?
    let username: String?
    let profileUrl: String?
    let intro: String?
    let deleted: Bool?
    let myMeetingsId: Array<Int>?
    let likeMeetingsId: Array<Int>?
}
