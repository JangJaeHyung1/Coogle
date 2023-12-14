//
//  CreateRecipeAPI.swift
//  Coogle
//
//  Created by jh on 2023/02/08.
//

import RxSwift
import Foundation

class CreateRecipeAPI {
    static let shared = CreateRecipeAPI()
    private init() { }
    
    func requestAPI(userId: String, completion: @escaping (Result<String, Error>) -> Void) {

        guard let url: URL = URL(string: "http://localhost:8000/api/v1/recipes") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"

        // Set HTTP Request Header
        requestUrl.setValue("application/json", forHTTPHeaderField: "Accept")
        requestUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode), let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            do{
                let apiResponse = try JSONDecoder().decode(String.self, from: data)
                completion(.success(apiResponse))
            } catch (let err){
                print(err.localizedDescription)
                completion(.failure(APIError.invalidRequest))
            }
        }.resume()
    }
    
    func uploadRecipeAPI(userId: String, recipedata: RecipeData, completion: @escaping (Result<String, Error>) -> Void) {

        guard let url: URL = URL(string: "http://localhost:8000/api/v1/recipes") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "POST"
        do {
            let postData = try JSONEncoder().encode(recipedata)
            print("json data : \(postData)")
            requestUrl.httpBody = postData
        } catch {
            print(error.localizedDescription)
            completion(.failure(APIError.invalidRequest))
        }
        // Set HTTP Request Header
        requestUrl.setValue("application/json", forHTTPHeaderField: "Accept")
        requestUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestUrl.setValue( "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50IjoiMTIzNDEyMzQiLCJpYXQiOjE2NzY2MzQ1ODQsImV4cCI6MTY3NjYzODE4NH0.0RN4qPTIAtqUXiFdxnlbtBZxTqq-wUgpc-SJObpIZZs", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                print("🔴response err : \(error)")
                completion(.failure(APIError.invalidResponse))
                return
            }
            // 서버로부터 응답된 스트링 표시
            guard let data = data, let outputStr = String(data: data, encoding: String.Encoding.utf8) else {
                completion(.failure(APIError.invalidRequest))
                return
            }
            print("result: \(outputStr)")
            completion(.success(outputStr))
        }.resume()
    }
}
