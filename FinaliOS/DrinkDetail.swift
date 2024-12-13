//
//  DrinkDetail.swift
//  FinaliOS
//
//  Created by Gurpreet Singh on 2024-12-13.
//

import Foundation

struct DrinkDetail: Codable {
    let idDrink: String
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strInstructions: String
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strDrinkThumb: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strMeasure1: String?
    let strMeasure2: String?
}
