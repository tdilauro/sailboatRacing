//
//  File.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import Foundation

class NauticalFlagsViewModel: ObservableObject {
    @Published var flagCategories: [FlagCategoryJSON] = []

    func loadData(apiURL: String) {
        guard let url = URL(string: apiURL) else {
            print("Invalid URL: '\(apiURL)'")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(FlagCategoriesJSON.self, from: data)
                DispatchQueue.main.async {
                    self.flagCategories = decodedData
                }
                return
            } catch {
                print(error)
            }

        }.resume()
    }
}


