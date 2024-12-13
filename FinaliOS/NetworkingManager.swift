//
//  NetworkManager.swift
//  FinaliOS
//
//  Created by Gurpreet Singh on 2024-12-13.
//

import Foundation


import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
        weak var delegate: NetworkingDelegate?

        private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1"

        // Fetch drinks by ingredient
        func fetchDrinksByIngredient(ingredient: String) {
            guard let url = URL(string: "\(baseURL)/filter.php?i=\(ingredient)") else { return }

            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.delegate?.didFailWithError(error)
                    return
                }

                guard let data = data else {
                    self.delegate?.didFailWithError(NSError(domain: "No data", code: 0, userInfo: nil))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode([String: [Drink]].self, from: data)
                    if let drinks = decodedData["drinks"] {
                        self.delegate?.didFetchDrinksList(drinks)
                    } else {
                        self.delegate?.didFailWithError(NSError(domain: "No drinks found", code: 0, userInfo: nil))
                    }
                } catch {
                    self.delegate?.didFailWithError(error)
                }
            }
            dataTask.resume()
        }

        // Fetch details for a specific drink
        func fetchDrinkDetails(drinkID: String) {
            guard let url = URL(string: "\(baseURL)/lookup.php?i=\(drinkID)") else { return }

            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.delegate?.didFailWithError(error)
                    return
                }

                guard let data = data else {
                    self.delegate?.didFailWithError(NSError(domain: "No data", code: 0, userInfo: nil))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode([String: [Drink]].self, from: data)
                    if let drink = decodedData["drinks"]?.first {
                        self.delegate?.didFetchDrinkDetails(drink)
                    } else {
                        self.delegate?.didFailWithError(NSError(domain: "Drink not found", code: 0, userInfo: nil))
                    }
                } catch {
                    self.delegate?.didFailWithError(error)
                }
            }
            dataTask.resume()
        }
    }
