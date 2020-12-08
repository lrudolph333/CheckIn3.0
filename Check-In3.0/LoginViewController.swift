//
//  LoginViewController.swift
//  Check-In3.0
//
//  Created by Lee Rudolph on 12/7/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
   
    /*@IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!*/
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var username : String?

    var link: String!
    @IBOutlet weak var usernameFeild: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false

        // Do any additional setup after loading the view.
        if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
            //push the new view controller
        }
        if let link = UserDefaults.standard.value(forKey: "Link") as? String {
          self.link = link
          loginButton.isEnabled = true
        }
    }
    
    
    @IBAction func usernameChanged(_ sender: Any) {
        if let newUsername = usernameFeild.text {
            username = newUsername;
            loginButton.isEnabled = (newUsername != "");
        }
    }
    
    @IBAction func loginClick(_ sender: Any) {
        UserDefaults.standard.set(username, forKey: "username")
        db.collection("users").whereField("username", isEqualTo: username)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if (querySnapshot!.isEmpty) {
                        print("username taken!")
                        return
                    }
                }
        }
        ref = db.collection("users").addDocument(data: [
            "username": usernameFeild.text ?? "nousername",
            "favorites": []
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
        //Push the new view controller
    }
    /*
     @IBOutlet weak var LoginButtonOutlet: UIButton!
       @IBOutlet weak var EnterUsernameOutlet: UITextField!
       var username : String?
       let db = Firestore.firestore()
       var ref: DocumentReference? = nil

       override func viewDidLoad() {
           super.viewDidLoad()
           LoginButtonOutlet.isEnabled = false;

           //Trey has been here :)li
           // Do any additional setup after loading the view.
       }
       
       @IBAction func UsernameEdit(_ sender: Any) {
           if let newUsername = EnterUsernameOutlet.text {
               username = newUsername;
               LoginButtonOutlet.isEnabled = (newUsername != "");
           }
       }
       
       @IBAction func LoginButtonClicked(_ sender: Any) {
           ref = db.collection("users").addDocument(data: [
               "username": EnterUsernameOutlet.text ?? "nousername",
               "favorites": []
           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: \(self.ref!.documentID)")
               }
           }
           //let detailedVC = MovieDetailsViewController()
           /*print("id: \(response?.results[indexPath.row].id)")
           detailedVC.title = response?.results[indexPath.row].title
           detailedVC.image = imageCache[indexPath.item]
           detailedVC.releaseDate = response?.results[indexPath.row].release_date
           detailedVC.score = response?.results[indexPath.row].vote_average
           detailedVC.rating = response?.results[indexPath.row].overview
           detailedVC.id = response?.results[indexPath.row].id*/
           //navigationController?.pushViewController(detailedVC, animated: true)
       }
       
    @IBAction func sendEmailButtonClick(_ sender: Any) {
         if let email = self.emailTextField.text {
            //showSpinner {
              // [START action_code_settings]
              let actionCodeSettings = ActionCodeSettings()
              actionCodeSettings.url = URL(string: "https://check-in3.firebaseapp.com")
              // The sign-in operation has to always be completed in the app.
              actionCodeSettings.handleCodeInApp = true
              actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
              //actionCodeSettings.setAndroidPackageName("com.example.android",
               //                                        installIfNotAvailable: false, minimumVersion: "12")
              // [END action_code_settings]
              // [START send_signin_link]
            print("bundle \(Bundle.main.bundleIdentifier!)");

              Auth.auth().sendSignInLink(toEmail:email,
                                         actionCodeSettings: actionCodeSettings) { error in
                // [START_EXCLUDE]
                //self.hideSpinner {
                  // [END_EXCLUDE]
                                            print("In auth send signINLink");

                  if let error = error {
                    //self.showMessagePrompt(error.localizedDescription)
                    print("Error:" + error.localizedDescription)
                    //print("Error Details:" + error)
                    let castedError = error as NSError
                    let firebaseError = AuthErrorCode(rawValue: castedError.code)
                    if firebaseError != nil {
                        print("Error Code: \(castedError.code)")
//                            switch(firebaseError!) {
//                            case .errorCodeWrongPassword:
//                                //do something or break
//                                break
//                            default:
//                                //do something or break
//                                break
                        
                    }
                    return
                  }
                                    
                  // The link was successfully sent. Inform the user.
                  // Save the email locally so you don't need to ask the user for it again
                  // if they open the link on the same device.
                  UserDefaults.standard.set(email, forKey: "Email")
                  print("check your email for link")

                  //self.showMessagePrompt("Check your email for link")
                  // [START_EXCLUDE]
                //}
                // [END_EXCLUDE]
              }
              // [END send_signin_link]
            //}
          } else {
            print("email can't be emptyy")
            //self.showMessagePrompt("Email can't be empty")
          }
        
    }
 */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}