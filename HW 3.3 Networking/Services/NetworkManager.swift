//
//  NetworkManager.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 12.09.2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case jsonUrl = "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json"
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchEmojis(from url: String, completion: @escaping(Result<[Emoji], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let emojis = Emoji.getEmojis(from: value)
                    completion(.success(emojis))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // TODO: delete this method
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "no error description")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
}
