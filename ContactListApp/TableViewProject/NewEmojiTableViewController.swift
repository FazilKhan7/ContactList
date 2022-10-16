//
//  NewEmojiTableViewController.swift
//  TableViewProject
//
//  Created by Bakhtiyarov Fozilkhon on 03.10.2022.
//

import UIKit

class NewEmojiTableViewController: UITableViewController , UIPickerViewDelegate, UIPickerViewDataSource{

    var emoji = Prezident(image: UIImage(named: "male")!, name: "", description: "", isFavourite: false)
    var gender: String = ""
    var isBool: Bool = false
    
    @IBOutlet weak var imageViewDis: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pickerPerson: UIPickerView!
    
    var pickerData: [String] = ["Male" , "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerPerson.delegate = self
        self.pickerPerson.dataSource = self
        updataUi()
        updataSaveButton()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = pickerData[row]
    }
        
    private func updataSaveButton() {
        let emojiName = nameLabel.text ?? ""
        let emojiDescription = descriptionLabel.text ?? ""
        saveButton.isEnabled = !emojiName.isEmpty && !emojiDescription.isEmpty
    }

    private func updataUi(){
        imageViewDis.image = emoji.image
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
    }
    
    @IBAction func isEnabled(_ sender: Any) {
        updataSaveButton()
    }
    
     @IBAction func pickImage(_ sender: Any) {
         let vc = UIImagePickerController()
         vc.sourceType = .photoLibrary
         vc.delegate = self
         vc.allowsEditing = true
         present(vc, animated: true)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        let name = nameLabel.text ?? ""
        let description = descriptionLabel.text ?? ""
        if isBool == false && gender == "Male" {
            imageViewDis.image = UIImage(named: "male")!
        }else if isBool == false && gender == "Female" {
            imageViewDis.image = UIImage(named: "female")!
        }
        self.emoji = Prezident(image: imageViewDis.image!, name: name, description: description, isFavourite: self.emoji.isFavourite)
    }
}

extension NewEmojiTableViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
           imageViewDis.image = image
            isBool = true
        }
        picker.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true , completion: nil)
    }
}

