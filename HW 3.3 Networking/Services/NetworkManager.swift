//
//  NetworkManager.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 12.09.2023.
//

import Foundation

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
    
    func fetchEmoji(from url: String, completion: @escaping(Result<[Emoji], NetworkError>) -> Void) {
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
            
            do {
                let emoji = try JSONDecoder().decode([Emoji].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(emoji))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
