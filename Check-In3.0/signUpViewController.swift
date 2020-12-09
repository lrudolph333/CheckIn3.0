//
//  ViewController.swift
//  fpSignUp
//
//  Created by Arric Lucas on 12/8/20.
//  Copyright © 2020 Arric Lucas. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    

  


    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    
    @IBOutlet weak var createAccBtn: UIButton!
    
    
    @IBAction func createAccClick(_ sender: Any) {
        //here is where we will handle sending all of the info to the database
        //we may want to search the database for emails and/or usernames so that duplicate accounts are not created
        
        print("in click")
        //we must check that both passwords match and that each is filled out
        //handles case where there are fields that need to be filled out
        if(userName.text! == ""  || email.text! == "" || password.text! == "" || confirmPassword.text! == "" || firstName.text! == "" || lastName.text! == "" ){
            
            print("woooow")
            let alert = UIAlertController(title: "Error", message: "One or more of the fields are not filled out. Please complete all fields." , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        //handles case where passwords are not the same
        if(password.text != confirmPassword.text){
            print("no p match")
            let alert = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        //need a case to check if username and/or email already exists in database
        
        //after these edge cases, we can add functionality to add all of this information to firBase
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
          password.textContentType = .oneTimeCode
          confirmPassword.textContentType = .oneTimeCode
    }


}

