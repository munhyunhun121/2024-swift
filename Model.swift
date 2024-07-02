//
//  Model.swift
//  2024
//
//  Created by 문현권 on 2024/6/24.
//

import Foundation
import Combine

struct Customer: Identifiable, Hashable, Codable {
    let id = UUID()
    let name: String
    var region: String
}

struct Visit: Identifiable {
    let id = UUID()
    let date: Date
    var customers: [Customer]
}



