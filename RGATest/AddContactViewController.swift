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

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var butImage: UIButton!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtBirthdate: SkyFloatingLabelTextField!
    @IBOutlet weak var txtBio: KMPlaceholderTextView!
    
    var selectedDate: Date?
    var selectedImage: UIImage?
    
    var isViewUp = false
    var currentInputFrame: CGRect?
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        self.butImage.roundView()
        self.butImage.clipsToBounds = true
        
        // IQKeyboardManager doesn't handle well with UITextFieldDelegate, so I have to implement the UITapGestureRecognizer since I'm not using the keyboard but the DatePickerDialog
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBirthdate))
        tapRecognizer.delegate = self
        self.txtBirthdate.addGestureRecognizer(tapRecognizer)
    }
    
    func didTapBirthdate() {
        
        self.txtBirthdate.resignFirstResponder()
        DatePickerDialog().show(title: "Selecione a Data de Nascimento", doneButtonTitle: "OK", cancelButtonTitle: "Cancelar", maximumDate: Date(), datePickerMode: .date) { (date) -> Void in
            
            if let date = date {
                let dateStr = date.toString(format: "dd/MM/yyyy")
                self.txtBirthdate.text = dateStr
                self.selectedDate = date
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func butImage(_ sender: Any) {
     
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = 1
        Configuration.doneButtonTitle = "Terminar"
        Configuration.noImagesTitle = "Desculpa! Não existe nenhuma imagem aqui!"

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
