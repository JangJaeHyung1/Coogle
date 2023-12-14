//
//  RequestAPI.swift
//  Coogle
//
//  Created by jh on 2023/02/08.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidRequest
}

//struct APIResponse<T: Codable>: Codable {
//    let data: T
//}
//
//class APIClient {
//    func get<T: Codable>(urlString: String, content: T) async throws -> T {
//        guard let url = URL(string: urlString) else {
//            throw APIError.invalidURL
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("APIError.invalidResponse error: \(error)")
//                throw APIError.invalidResponse
//            }
//
//            guard let data = data else {
//                throw APIError.invalidResponse
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                if let response = response as? HTTPURLResponse,
//                   (200..<300).contains(response.statusCode) {
//                    print("URLSession data: \(String(describing: data))")
//                    let response = try decoder.decode(T.self, from: data)
//                    return response
//                } else {
//                    throw APIError.invalidRequest
//                }
//            } catch {
//                throw APIError.invalidRequest
//            }
//        }.resume()
//    }
//}
