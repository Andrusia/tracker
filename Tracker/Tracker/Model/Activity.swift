//
//  ExerciseSet.swift
//  Tracker
//
//  Created by Andrei Panasik on 18.12.21.
//

import Foundation

struct Activity: Codable {
    let userId: Int
    let exercise: Exercise
    let amount: Int
    let date: Date

    var hoursAndMinutes: String {
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm"
        return formater.string(from: date)
    }

    var currentDay: String {
        let formater = DateFormatter()
        formater.dateFormat = "yyMMdd"
        return formater.string(from: date)
    }

    var dateForSection: String {
        let formater = DateFormatter()
        formater.dateFormat = "EEEE, MM/dd "
        return formater.string(from: date)
    }
}
