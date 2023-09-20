//
//  Emoji.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 08.09.2023.
//

struct Emoji: Decodable {
    let emoji: String
    let description: String
    let category: String
    let iosVersion: String
    
    // TODO: try delete this
    init(emoji: String, description: String, category: String, iosVersion: String) {
        self.emoji = emoji
        self.description = description
        self.category = category
        self.iosVersion = iosVersion
    }
    
    init(emojiData: [String: Any]) {
        emoji = emojiData["emoji"] as? String ?? ""
        description = emojiData["description"] as? String ?? ""
        category = emojiData["category"] as? String ?? ""
        iosVersion = emojiData["ios_version"] as? String ?? ""
    }
    
    static func getEmojis(from value: Any) -> [Emoji] {
        guard let emojisData = value as? [[String: Any]] else { return [] }
        return emojisData.map { Emoji(emojiData: $0) }
    }
}
