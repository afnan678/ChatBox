//
//  UploadDetailsViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 29/01/2024.
//

import UIKit

class UploadDetailsViewController: UIViewController {

    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    var viewModel: UploadDetailsviewModel!
    var number = ""
    var UserId = ""
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureTextField()
        print(number + UserId)

        // Do any additional setup after loading the view.
    }
    @IBAction func continueButtonClick(_ sender: Any) {
        if continueButton.alpha == 1 {
            viewModel.createRequest(ProfileImg: profileImageView.image!, id: UserId, serialNo: "001", name: nameTextField.text ?? "", phoneNo: number)
        }
    }
    
    
    func ConfigureUi() {
        
    }
}

extension UploadDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func configureImageView() {
        let  tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(self.openGallery(tapGesture:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
    }

    @objc func openGallery(tapGesture: UITapGestureRecognizer) {
        setypImagePicker()
    }
    
    func setypImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            self.present (imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]as! UIImage
        profileImageView.image = image
        self.dismiss (animated: true, completion: nil)
    }
}

extension UploadDetailsViewController: UITextFieldDelegate {
    
    func configureTextField() {
        nameTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Get the current text in the text field
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        // Check if the first character is not an empty space or if the entire text is empty
        if updatedText.isEmpty || !CharacterSet.whitespaces.contains(updatedText.first!.unicodeScalars.first!) {
            
            if updatedText.count >= 2 {
                continueButton.alpha = 1
            } else {
                continueButton.alpha = 0.25
            }
            if updatedText.count > 30 {
                    return false
                }
                // Print the remaining characters
            let remainingCharacters = 30 - updatedText.count
            characterLabel.text = " Character \(remainingCharacters)/30"
            return true
        } else {
            return false
        }
            return true
        }
}
