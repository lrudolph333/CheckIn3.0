//
//  LoginViewController.swift
//  Check-In3.0
//
//  Created by Lee Rudolph on 12/7/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class LoginViewController: UIViewController {
    
   
    /*@IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!*/
    let db = Firestore.firestore()
    var ref : DocumentReference? = nil
    var username : String?
    var password : String?
    var link: String!
    @IBOutlet weak var usernameFeild: UITextField!
    @IBOutlet weak var passwordFeild: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        registerButton.isEnabled = false
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navViewController.self, action: nil)
        navigationItem.leftBarButtonItem = backButton

        // Do any additional setup after loading the view.
        if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
            //push the new view controller
            if let storedUserID = UserDefaults.standard.value(forKey: "userID") as? String {
                ref = db.collection("users").document(storedUserID)
                //Calculating current day, vs last check in day
                let date = Date()
                let calendar = Calendar.current
                let today = calendar.component(.day, from: date)
                print("Today: \(today)");
                
                ref?.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let lastDate = document.data()?["lastCheckInDate"] as? Date
                        let lastDay = calendar.component(.day, from: lastDate ?? date)
                        print("Last day: \(lastDay)")
                        if(lastDay != today) {
                            //push the check in view controller
                            let initialCheckIn = self.storyboard?.instantiateViewController(withIdentifier: "initialCheckIn") as! EverydayCheckInViewController
                            self.navigationController?.pushViewController(initialCheckIn, animated: true)
                        } else {
                            //push home view controller
                            let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "homeTabController") as! UITabBarController
                            self.navigationController?.pushViewController(homeScreen, animated: true)
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            }

        }
    }
    
    
    @IBAction func usernameChanged(_ sender: Any) {
        if let newUsername = usernameFeild.text {
            username = newUsername;
            loginButton.isEnabled = (username != "" && password != "");
            registerButton.isEnabled = (username != "" && password != "");

        }
    }
    
    @IBAction func passwordEdit(_ sender: Any) {
        if let newPassword = passwordFeild.text {
            password = newPassword;
            loginButton.isEnabled = (username != "" && password != "");
            registerButton.isEnabled = (username != "" && password != "");
        }
    }
    
    @IBAction func loginClick(_ sender: Any) {
        db.collection("users").whereField("username", isEqualTo: self.usernameFeild.text)
                   .getDocuments() { (querySnapshot, err) in
                       if let err = err {
                           print("Error getting documents: \(err)")
                       } else if (querySnapshot!.isEmpty) {
                               print("username not found!")
                           //Show that username is taken
                                let alert = UIAlertController(title: "Error", message: "Username not found", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                                self.present(alert, animated: true)
                               return
                       } else {
                            let data = querySnapshot?.documents[0].data()
                        //let title = data["title"] as? String ?? ""
                            let password = data!["password"] as? String ?? ""
                            if(password != self.password) {
                                    //show password as inorrect
                                    print("password incorrect")
                                    let alert = UIAlertController(title: "Error", message: "Password is incorrect", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                                    self.present(alert, animated: true)
                            }
                            else {
                                UserDefaults.standard.set(self.username, forKey: "username")
                                UserDefaults.standard.set(querySnapshot?.documents[0].documentID, forKey: "userID")
                                
                                let initialCheckIn = self.storyboard?.instantiateViewController(withIdentifier: "initialCheckIn") as! EverydayCheckInViewController
                                
                                self.navigationController?.pushViewController(initialCheckIn, animated: true)
                                    //***********************
                                    //push view controller
                                    //***********************
                                    print("access granted")

                                    //let checkInScreen = CheckInViewController()
                                    //self.navigationController?.pushViewController(checkInScreen, animated: true)
                            }
                       }
               }
         
        //Push the new view controller
    }
    
    
    @IBAction func registerClick(_ sender: Any) {
        db.collection("users").whereField("username", isEqualTo: self.usernameFeild.text)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else if (!querySnapshot!.isEmpty) {
                        print("username taken!")
                        //Show that username is taken
                        let alert = UIAlertController(title: "Error", message: "Username is taken.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        return
                } else {
                    self.ref = self.db.collection("users").addDocument(data: [
                        "username": self.username!,
                        "password": self.password!,
                        "favorites": [],
                        "stats": [
                            "sleep": 0,
                            "stress": 0,
                            "academics": 0,
                            "anxiety": 0,
                            "depression": 0,
                        ]
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(self.ref!.documentID)")
                            UserDefaults.standard.set(self.username, forKey: "username")
                            UserDefaults.standard.set(self.ref!.documentID, forKey: "userID")
                            //***********************
                            //push view controller
                            //***********************
                            //added push vc

                            let initialCheckIn = self.storyboard?.instantiateViewController(withIdentifier: "initialCheckIn") as! EverydayCheckInViewController
                            
                            self.navigationController?.pushViewController(initialCheckIn, animated: true)
                            
                            
                        }
                    }
                }
        }

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
