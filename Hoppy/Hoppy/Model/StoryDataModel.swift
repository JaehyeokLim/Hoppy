//
//  StoryDataModel.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/05.
//

import UIKit

var StoryTotalDataList = [StoryTotalDataModel]()
var StoryDetailDataList = [StoryDetailDataModel]()

struct StoryTotalDataModel {
    let status: Int?
    let message: String?
}

struct StoryDetailDataModel {
    let id: Int?
    let memberId: Int?
    let profileUrl: String?
    let username: String?
    let title: String?
    let filename: String?
    let content: String?
    let liked: Bool?
    let likeCount: Int?
    let replyCount: Int?
    let createDate: String?
}
