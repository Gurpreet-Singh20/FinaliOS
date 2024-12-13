//
//  DrinkDetailsViewController.swift
//  FinaliOS
//
//  Created by Gurpreet Singh on 2024-12-13.
//

import Foundation
import UIKit

class DrinkDetailsViewController: UIViewController, NetworkingDelegate {
    var drinkID: String?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var alcoholicLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingManager.shared.delegate = self
        if let drinkID = drinkID {
            NetworkingManager.shared.fetchDrinkDetails(drinkID: drinkID)
        }
    }

    func didFetchDrinksList(_ drinks: [Drink]) {
        // Not needed here
    }

    func didFetchDrinkDetails(_ drink: Drink) {
        DispatchQueue.main.async {
            self.nameLabel.text = drink.strDrink
            self.categoryLabel.text = drink.strCategory
            self.alcoholicLabel.text = drink.strAlcoholic
            self.instructionsLabel.text = drink.strInstructions
            if let imageURL = URL(string: drink.strDrinkThumb) {
                self.drinkImageView.loadImage(from: imageURL)
            }
        }
    }

    func didFailWithError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
