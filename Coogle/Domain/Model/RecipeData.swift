//
//  RecipeInfo.swift
//  Coogle
//
//  Created by jh on 2023/02/08.
//

import Foundation

// MARK: - Welcome
struct RecipeData: Codable {
    let title: String
    let serving: Int
    let description: String
    let level: Int
    let categoryId: Int
    let contents: [Content]
    let ingredients: [Ingredient]
    let condiments: [Condiment]
}

// MARK: - Condiment
struct Condiment: Codable {
    let condiment, amount: String
}

// MARK: - Content
struct Content: Codable {
    let step: Int
    let image, text: String
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let ingredient, amount: String
}

//let testData = RecipeData(title: "title01",
//                          serving: 2,
//                          description: "description01",
//                          level: 1,
//                          category: "123",
//                          contents: [Content(step: 1, image: "이미지 URL", text: "해당 단계 설명"),
//                                     Content(step: 2, image: "이미지 URL", text: "해당 단계 설명"),
//                                     Content(step: 3, image: "이미지 URL", text: "해당 단계 설명")],
//                          ingredients: [Ingredient(ingredient: "재료명", amount: "수량"),
//                                        Ingredient(ingredient: "재료명", amount: "수량"),
//                                        Ingredient(ingredient: "재료명", amount: "수량")],
//                          condiments: [Condiment(condiment: "재료명", amount: "수량"),
//                                       Condiment(condiment: "재료명", amount: "수량")])
