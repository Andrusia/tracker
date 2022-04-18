//
//  Exercise.swift
//  Tracker
//
//  Created by Andrei Panasik on 18.12.21.
//

import Foundation

enum Exercise: String, CaseIterable, Codable {
    case pullUps
    case pushUps
    case squats
    case abs
    
    var title: String {
        return rawValue
    }
    
    var muscleGroup: [MuscleGroup] {
        switch self {
        case .pullUps:
            return [.back, .biceps]
        case .pushUps:
            return [.chest, .triceps]
        case .squats:
            return [.legs]
        case .abs:
            return [.abs]
        }
    }
    
    var equipment: Equipement {
        return .no
    }
}
