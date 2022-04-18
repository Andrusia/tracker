//
//  Users.swift
//  Tracker
//
//  Created by Andrei Panasik on 7.01.22.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let email: String 
    let password: String
    var friendsId: [Int:Int] = [:]
}
