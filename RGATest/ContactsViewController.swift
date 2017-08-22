//
//  ContactsViewController.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable line_length

import UIKit
import Kingfisher
import RealmSwift
import Realm

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var contacts: Results<Contact>?
    @IBOutlet weak var search: UISearchBar!
    
    let viewModel = ContactViewModel()
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        viewModel.getContacts { (contacts) in
            
            if let contacts = contacts {
                self.contacts = contacts
                self.table.reloadData()
                self.observeRealmContacts()
            }
        }
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
    }
    
    func observeRealmContacts() {
        
        // Observe Results Notifications
        notificationToken = contacts?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            
            print("change")
            guard let tableView = self?.table else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .top)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .top)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .top)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
            
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func butEditTable(_ sender: Any) {
        
        table.setEditing(!table.isEditing, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ContactDetailViewController {
            dest.contact = sender as? Contact
        } else {
            
            // Resetting filter
            search.text = ""
            search.resignFirstResponder()
            search.showsCancelButton = false
            contacts = viewModel.searchContacts(text: "")
            table.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            viewModel.remove(contact: contacts![indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let contacts = contacts {
            return contacts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContactTableViewCell
        
        let contact = contacts![indexPath.row]
        cell?.lblContactName.text = contact.name
        if let url = URL(string: contact.photoURL) {
            cell?.imgvContact.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "EmptyUser"))
        } else {
            cell?.imgvContact.image = #imageLiteral(resourceName: "EmptyUser")
        }
        
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.Segues.selectedContact, sender: contacts?[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // If user deleted all text and scrolled, removing cancel button
        if search.text == "" {
            self.search.showsCancelButton = false
        }
        self.search.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension ContactsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchBar.showsCancelButton = true
        contacts = viewModel.searchContacts(text: searchText)
        table.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        contacts = viewModel.searchContacts(text: "")
        table.reloadData()
        searchBar.resignFirstResponder()
    }
}
