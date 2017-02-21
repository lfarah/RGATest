//
//  ContactDetailViewController.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable line_length

import UIKit
import MessageUI
import ImagePicker

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var imgvContact: UIImageView!
    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var txtContactBio: UITextView!
    @IBOutlet weak var table: UITableView!
    
    var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imgvContact.kf.setImage(with: contact.photoURL, placeholder: #imageLiteral(resourceName: "EmptyUser"))
        imgvContact.roundSquareImage()
        imgvContact.addBorder(width: 3, color: .white)
        lblContactName.text = contact.name
        txtContactBio.text = contact.bio
        table.tableFooterView = UIView()
    }
    
    @IBAction func butBack(_ sender: Any) {
        
        self.popVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension ContactDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If there's no birthdate, only shows 1 cell
        return contact.birthdate != nil ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        // setup cell without force unwrapping it
        
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Email:"
            cell?.detailTextLabel?.text = contact.email
        } else {
            
            if let birthdate = contact.birthdate {
                cell?.textLabel?.text = "Data de Nascimento:"
                cell?.detailTextLabel?.text = birthdate.toString(format: "dd MMMM yyyy")
            }
        }
        
        return cell!
    }
}

extension ContactDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            //Email
            let recipients = [contact.email]
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(recipients)
            
            self.present(composer, animated: true, completion: nil)
        }
    }
}

extension ContactDetailViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismissVC(completion: nil)
    }
}
