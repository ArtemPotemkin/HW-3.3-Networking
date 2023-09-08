//
//  MainViewController.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 08.09.2023.
//

import UIKit

final class MainViewController: UITableViewController {
    
    let emojisMok = EmojiMok.getEmoji()
    var emojis: [Emoji] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        fetchEmojis()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath)
        guard let cell = cell as? EmojiCell else { return UITableViewCell() }
        let emoji = emojis[indexPath.row]
        cell.emojiLabel.text = emoji.emoji
        cell.descriptionLabel.text = emoji.description
        cell.categoryLabel.text = emoji.category
        
        return cell
    }
}


// MARK: - Networking
extension MainViewController {
    func fetchEmojis() {
        guard let url = URL(string: "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self?.emojis = try decoder.decode([Emoji].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
