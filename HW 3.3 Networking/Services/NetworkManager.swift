//
//  NetworkManager.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 12.09.2023.
//

import Foundation
import Alamofire

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
}
