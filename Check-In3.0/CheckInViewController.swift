//
//  CheckInViewController.swift
//  Check-In3.0
//
//  Created by Arric Lucas on 11/29/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit
import Firebase


class CheckInViewController: UIViewController {
    let db = Firestore.firestore()
    //var ref: DocumentReference? = nil
    var docRef : DocumentReference? = nil

    @IBOutlet weak var sleepBtn: UIButton!
    
    
    @IBOutlet weak var academicsBtn: UIButton!
    
    @IBOutlet weak var stressBtn: UIButton!
    
    @IBOutlet weak var anxietyBtn: UIButton!
    
    @IBOutlet weak var depressionBtn: UIButton!
    
    var sleepPick : Bool = false;
    var academicsPick = false;
    var stressPick = false;
    var anxietyPick = false;
    var depressionPick = false;
    
    
    @IBAction func sleepClick(_ sender: Any) {
        if(sleepPick == false){
            sleepBtn.backgroundColor = UIColor.gray;
            sleepPick = true;
            
        }
        else if(sleepPick == true){
            sleepBtn.backgroundColor = UIColor.white;
            sleepPick = false;
        }
    }
    
    
    @IBAction func academicsClick(_ sender: Any) {
        if(academicsPick == false){
            academicsBtn.backgroundColor = UIColor.gray;
            academicsPick = true;
            
        }
        else if(academicsPick == true){
            academicsBtn.backgroundColor = UIColor.white;
            academicsPick = false;
        }
    }
    
    
    @IBAction func stressClick(_ sender: Any) {
    if(stressPick == false){
        stressBtn.backgroundColor = UIColor.gray;
        stressPick = true;
        
    }
    else if(stressPick == true){
        stressBtn.backgroundColor = UIColor.white;
        stressPick = false;
    }
    }
    
    @IBAction func anxietyClick(_ sender: Any) {
        if(anxietyPick == false){
            anxietyBtn.backgroundColor = UIColor.gray;
            anxietyPick = true;
            
        }
        else if(anxietyPick == true){
            anxietyBtn.backgroundColor = UIColor.white;
            anxietyPick = false;
        }
    }
    
    @IBAction func depressionClick(_ sender: Any) {
        if(depressionPick == false){
            depressionBtn.backgroundColor = UIColor.gray;
            depressionPick = true;
            
        }
        else if(depressionPick == true){
            depressionBtn.backgroundColor = UIColor.white;
            depressionPick = false;
        }

    }
 
    @IBAction func submitClick(_ sender: Any) {
        //let storedUserID = UserDefaults.standard.value(forKey: "userID") as? String
        //db.collection("cities").document("BJ")
       // ViewController.swift

            docRef?
            .updateData([
                "stats.sleep" : FieldValue.increment(Int64(Int(NSNumber(value:sleepPick)))),
                "stats.stress" : FieldValue.increment(Int64(Int(NSNumber(value:stressPick)))),
                "stats.depression" : FieldValue.increment(Int64(Int(NSNumber(value:depressionPick)))),
                "stats.academics" : FieldValue.increment(Int64(Int(NSNumber(value:academicsPick)))),
                "stats.anxiety" : FieldValue.increment(Int64(Int(NSNumber(value:anxietyPick)))),
            ])
        
        /*Navigate to Home*/
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docRef = db.collection("users").document(UserDefaults.standard.value(forKey: "userID") as! String)
        // Do any additional setup after loading the view.
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
