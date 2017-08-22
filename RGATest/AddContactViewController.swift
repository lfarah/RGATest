//
//  AddContactViewController.swift
//  RGATest
//
//  Created by Lucas Farah on 2/20/17.
//  Copyright © 2017 Awesome Labs. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace

import UIKit
import SkyFloatingLabelTextField
import KMPlaceholderTextView
import DatePickerDialog
import ImagePicker
import Kingfisher

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var butImage: UIButton!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtBirthdate: SkyFloatingLabelTextField!
    @IBOutlet weak var txtBio: KMPlaceholderTextView!
    
    var selectedDate: Date? {
        didSet {
            self.txtBirthdate.text = selectedDate?.toString(format: "dd/MM/yyyy")
        }
    }
    var selectedImage: UIImage?
    
    var isViewUp = false
    var currentInputFrame: CGRect?
    var scrollView: UIScrollView?
    var selectedContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.butImage.roundView()
        self.butImage.clipsToBounds = true
        
        // IQKeyboardManager doesn't handle well with UITextFieldDelegate, so I have to implement the UITapGestureRecognizer since I'm not using the keyboard but the DatePickerDialog
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBirthdate))
        tapRecognizer.delegate = self
        self.txtBirthdate.addGestureRecognizer(tapRecognizer)
        
        let saveItem = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(saveUser))
        navigationItem.rightBarButtonItem = saveItem
        
        if let selectedContact = selectedContact {
            
            // Edit User
            self.txtName.text = selectedContact.name
            self.txtEmail.text = selectedContact.email
            self.txtBio.text = selectedContact.bio
            self.selectedDate = selectedContact.birthdate
            
            let url = URL(string: selectedContact.photoURL)!
            self.butImage.kf.setImage(with: url, for: .normal, placeholder: #imageLiteral(resourceName: "EmptyUser"), completionHandler: { (image, _, _, _) in
                self.selectedImage = image
            })
            
            self.title = "Editar Contato"
        } else {
            // Add User
            self.title = "Adicionar Contato"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func saveUser() {
        
        // Hiding keyboard when pressing save
        self.view.endEditing(true)
        
        guard let name = self.txtName.text, name != "" else {
            
            Notifier().localAlertError(error: "Por favor coloque um nome")
            self.txtName.becomeFirstResponder()
            return
        }
        
        guard let email = self.txtEmail.text, email != "" else {
            Notifier().localAlertError(error: "Por favor coloque um email")
            self.txtEmail.becomeFirstResponder()
            return
        }
        
        guard let birthdate = selectedDate else {
            Notifier().localAlertError(error: "Por favor coloque uma data de aniversário")
            return
        }
        
        guard let bio = self.txtBio.text, bio != "" else {
            Notifier().localAlertError(error: "Por favor coloque uma bio")
            self.txtBio.becomeFirstResponder()
            return
        }
        
        let image = selectedImage // Image is optional
        
        let contact = Contact()
        contact.name = name
        contact.email = email
        contact.bio = bio
        contact.birthdate = birthdate
        contact.photoURL = DatabaseManager().save(image: image) ?? ""
        contact.id = selectedContact?.id ?? ContactViewModel().generateUniqueId()
        ContactViewModel().add(contact: contact)
        self.popToRootVC()
    }
    
    func didTapBirthdate() {
        
        self.txtBirthdate.resignFirstResponder()
        DatePickerDialog().show("Selecione a Data de Nascimento", doneButtonTitle: "OK", cancelButtonTitle: "Cancelar", maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            
            if let date = date {
                self.selectedDate = date
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func butImage(_ sender: Any) {
        
        var configuration = Configuration()
        configuration.doneButtonTitle = "Terminar"
        configuration.noImagesTitle = "Desculpa! Não existe nenhuma imagem aqui!"
        
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.imageLimit = 1
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate
extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        currentInputFrame = textField.frame
        if textField == txtName {
            
            self.txtEmail.becomeFirstResponder()
        } else if textField == txtEmail {
            
            self.txtEmail.resignFirstResponder()
        } else {
            
            self.txtBio.becomeFirstResponder()
        }
        return true
    }
    
}

// MARK: UITextViewDelegate
extension AddContactViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: ImagePickerDelegate
extension AddContactViewController: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        let selectedImage = images.first
        self.selectedImage = selectedImage
        self.butImage.setImage(selectedImage, for: .normal)
        imagePicker.dismissVC(completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        let selectedImage = images.first
        self.selectedImage = selectedImage
        self.butImage.setImage(selectedImage, for: .normal)
        imagePicker.dismissVC(completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismissVC(completion: nil)
    }
}

// MARK: UIGestureRecognizerDelegate
extension AddContactViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
