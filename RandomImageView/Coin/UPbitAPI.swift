//
//  UPbitAPI.swift
//  RandomImageView
//
//  Created by J Oh on 9/6/24.
//

import Foundation

struct UpbitAPI {
    
    private init() { }

    static func fetchAllMarket(completion: @escaping ([Coin]) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func fetchMarkets() async throws -> [Coin] {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode([Coin].self, from: data)
        return decodedData
    }
}
