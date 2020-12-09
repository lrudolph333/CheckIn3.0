//
//  addPostViewController.swift
//  Check-In3.0
//
//  Created by Arric Lucas on 12/9/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit

class addPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addedImage: UIImageView!
    var image:UIImage?
    var imagePicker = UIImagePickerController()

    
    
    @IBAction func btnClick() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
      
    }
 
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addedImage.image = image
        }

    }
    
    
    
    @IBAction func submitPost(_ sender: Any) {
        //handle sending picture contents and caption contents to the post database with a number of likes equal to 0
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

