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
}

struct EmojiMok {
    let emoji: String
    let description: String
    let category: String
    
    static func getEmoji() -> [EmojiMok] {
        let emojis = [
            EmojiMok(emoji: "👰‍♀️", description: "tasa", category: "gaaf"),
            EmojiMok(emoji: "😛", description: "tasfaa", category: "tahhdsa"),
            EmojiMok(emoji: "😡", description: "tasafsa", category: "tafsa"),
            EmojiMok(emoji: "⏳", description: "taassa", category: "tadfdsa"),
            EmojiMok(emoji: "💯", description: "taahfhsa", category: "tssasa"),
        ]
        return emojis
    }
}
