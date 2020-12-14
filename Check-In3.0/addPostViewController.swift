//
//  addPostViewController.swift
//  Check-In3.0
//
//  Created by Arric Lucas on 12/9/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class addPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var descip: UITextView!
    @IBOutlet weak var addedImage: UIImageView!
    var image:UIImage?
    var imagePicker = UIImagePickerController()
    var url2:URL?
    var url3:URL?
    let db = Firestore.firestore()
    
    @IBAction func btnClick() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
      
    }
 
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addedImage.image = image
        }
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                 url2 = url
                   
                }
        picker.dismiss(animated: true, completion: nil)
        
    }
    func uploadToCloud(fileURL : URL) {
            let storage = Storage.storage()
            
            let data = Data()
            
            let storageRef = storage.reference()
            
            let localFule = fileURL
            
        let photoRef = storageRef.child(fileURL.relativeString)
            
            let uploadTask = photoRef.putFile(from: localFule, metadata: nil) { (metadata, err) in
                guard let metadata = metadata else {
                    print(err?.localizedDescription)
                    return
                }
                photoRef.downloadURL { (url, error) in
                    self.url3 = url
                    self.otherStuff()
                }
;
                print("Photo Upload")
                
            }
            
        }

    @IBAction func submitPost(_ sender: Any) {
        //handle sending picture contents and caption contents to the post database with a number of likes equal to 0
        uploadToCloud(fileURL: url2!)
        
        
    }
    func otherStuff(){
        db.collection("posts").document().setData([
                                                    "creator": UserDefaults.standard.value(forKey: "username")!,
                                                                "likes": 0,
                                                                "quote": descip.text!,
                                                                "image": url3?.absoluteString,
            "timestamp": FirebaseFirestore.Timestamp()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }    }
    
}
