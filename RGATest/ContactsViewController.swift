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

class ContactsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var contacts: [Contact] = []
    @IBOutlet weak var search: UISearchBar!
    
    let viewModel = ContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.getContacts { (contacts) in
            self.contacts = contacts
            self.table.reloadData()
        }
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
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
        
        //TODO: Remove with Realm later
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContactTableViewCell
       
        let contact = contacts[indexPath.row]
        cell?.lblContactName.text = contact.name
        cell?.imgvContact.kf.setImage(with: contact.photoURL, placeholder: #imageLiteral(resourceName: "EmptyUser"))
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "selectedContact", sender: contacts[indexPath.row])
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
