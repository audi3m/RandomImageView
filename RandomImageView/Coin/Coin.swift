//
//  Coin.swift
//  RandomImageView
//
//  Created by J Oh on 9/6/24.
//

import Foundation

struct Coin: Hashable, Codable, Identifiable {
    let id = UUID()
    let market, koreanName, englishName: String
    var like = false

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
