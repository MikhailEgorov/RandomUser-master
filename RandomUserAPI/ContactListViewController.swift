//
//  ContactListViewController.swift
//  RandomUserAPI
//
//  Created by Егоров Михаил on 26.02.2023.
//

import UIKit

class ContactListViewController: UITableViewController {

    private var contacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        downloadData()
        setupRefreshControl()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailsViewController
        detailVC.result = sender as? User
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        content.text = contact.name?.first
        content.secondaryText = contact.name?.last
        
        if let imageURL = contact.picture?.thumbnail {
            NetworkManager.shared.fetchData(from: imageURL) { imageData in
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactListViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = contacts[indexPath.row]
        performSegue(withIdentifier: "showContact", sender: currentUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private Methods
extension ContactListViewController {
    @objc private func downloadData() {
        NetworkManager.shared.fetchUsers { contacts in
            self.contacts = contacts
            self.tableView.reloadData()
            if self.refreshControl != nil {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
    }
}


