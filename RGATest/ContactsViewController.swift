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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ContactViewModel().getContacts { (contacts) in
            self.contacts = contacts
            self.table.reloadData()
        }
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
    }
    
    @IBAction func butEditTable(_ sender: Any) {
        
        table.setEditing(!table.isEditing, animated: true)
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
    }
}
