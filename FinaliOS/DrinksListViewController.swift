//
//  DrinksListViewController.swift
//  FinaliOS
//
//  Created by Gurpreet Singh on 2024-12-13.
//

import Foundation
import UIKit

class DrinksListViewController: UITableViewController, NetworkingDelegate,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var drinks: [Drink] = []
        var currentSearchText: String = "gin" // Default search term

        override func viewDidLoad() {
            super.viewDidLoad()
            
            NetworkingManager.shared.delegate = self
            searchBar.delegate = self
            fetchDrinks(ingredient: currentSearchText) // Load initial data
        }

        func fetchDrinks(ingredient: String) {
            NetworkingManager.shared.fetchDrinksByIngredient(ingredient: ingredient)
        }

        // MARK: - Networking Delegate
        func didFetchDrinksList(_ drinks: [Drink]) {
            DispatchQueue.main.async {
                self.drinks = drinks
                self.tableView.reloadData()
            }
        }

        func didFetchDrinkDetails(_ drink: Drink) {
            // This method may not be relevant here, but the protocol requires it, so we implement it to conform.
            print("Fetched details for drink: \(drink.strDrink)")
        }

        func didFailWithError(_ error: Error) {
            DispatchQueue.main.async {
                print("Error: \(error.localizedDescription)")
            }
        }

        // MARK: - UITableView Data Source
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return drinks.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath)
            let drink = drinks[indexPath.row]
            cell.textLabel?.text = drink.strDrink
            return cell
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedDrink = drinks[indexPath.row]
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailsViewController") as! DrinkDetailsViewController
            detailsVC.drinkID = selectedDrink.idDrink
            navigationController?.pushViewController(detailsVC, animated: true)
        }

        // MARK: - UISearchBar Delegate
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                currentSearchText = "gin"
            } else {
                currentSearchText = searchText
            }
            fetchDrinks(ingredient: currentSearchText)
        }
    }
