//
//  MainViewController.swift
//  HW 3.3 Networking
//
//  Created by Артём Потёмкин on 08.09.2023.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var emojis: [Emoji] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Emojis"
        tableView.rowHeight = 100
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
        cell.configure(with: emoji)
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Networking
extension MainViewController {
    private func fetchEmojis() {
        NetworkManager.shared.fetch([Emoji].self, from: Link.jsonUrl.rawValue) { [unowned self] result in
            switch result {
            case .success(let emojis):
                self.emojis = emojis
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
