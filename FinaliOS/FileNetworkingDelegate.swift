//
//  FileNetworkingDelegate.swift
//  FinaliOS
//
//  Created by Gurpreet Singh on 2024-12-13.
//

import Foundation


protocol NetworkingDelegate: AnyObject {
    func didFetchDrinksList(_ drinks: [Drink])
    func didFetchDrinkDetails(_ drink: Drink)
    func didFailWithError(_ error: Error)
}
