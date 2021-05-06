//
//  Post.swift
//  redditDetails
//
//  Created by Bryson Jones on 5/5/21.
//

import Foundation


struct PostTopLevelObject: Codable {
    let data: PostSecondLevelObject
}

struct PostSecondLevelObject: Codable {
    let children: [PostThirdLevelObject]
}

struct PostThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let title: String
    let ups: Int
    let thumbnail: String
    let subreddit_name_prefixed: String
}

