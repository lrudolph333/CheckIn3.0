//
//  EverydayCheckInViewController.swift
//  Check-In3.0
//
//  Created by Lee Rudolph on 12/13/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit
import Firebase

class EverydayCheckInViewController: UIViewController {
    let db = Firestore.firestore()
    var docRef : DocumentReference? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        docRef = db.collection("users").document(UserDefaults.standard.value(forKey: "userID") as! String)
        print("UserID: \(docRef?.documentID)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doingWellClick(_ sender: Any) {
        docRef?.updateData([
            "lastCheckInDate": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    @IBAction func strugglingClick(_ sender: Any) {
        docRef?.updateData([
            "lastCheckInDate": FieldValue.serverTimestamp()
            //"lastCheckInDate": Timestamp.now().toDate()

        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
