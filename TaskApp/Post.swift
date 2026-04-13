//
//  Post.swift
//  TaskApp
//
//  Created by Varsha Sharma on 12/04/26.
//

import Foundation

nonisolated(unsafe) struct Post: Codable, @unchecked Sendable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
