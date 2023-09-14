//
//  EmojiCell.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 08.09.2023.
//

import UIKit

final class EmojiCell: UITableViewCell {
    
    @IBOutlet var emojiLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var iosVersionLabel: UILabel!
    
    func configure(with emoji: Emoji) {
        emojiLabel.text = emoji.emoji
        descriptionLabel.text = emoji.description
        categoryLabel.text = "Category: \(emoji.category)"
        iosVersionLabel.text = "iOS version: \(emoji.iosVersion)"
    }
}
