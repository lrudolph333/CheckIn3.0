//
//  homePageViewController.swift
//  Check-In3.0
//
//  Created by Arric Lucas on 12/9/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit
import Firebase

class homePageViewController: UIViewController {
    let storage = Storage.storage()

    
    
    @IBOutlet weak var scrollV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navViewController.self, action: nil)
        navigationItem.leftBarButtonItem = backButton
        //self.navigationItem.hidesBackButton = true
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())

        //let pathReference = storage.reference(withPath: "posts/")
        let storageRef = storage.reference()
        //let imagesRef = storageRef.child("posts")
        let db = Firestore.firestore()
        //gs://check-in3.appspot.com/posts
        let gsReference = storage.reference(forURL: "gs://check-in3.appspot.com/")

        
        var scrollSize = 0
        var scrollWidth = 0
        //var image = UIImage(named: "postImage1")
        var y = 0
        
        db.collection("posts")
            .order(by: "timestamp", descending: false).limit(to: 12)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    var image = UIImage(named: "postImage1")
                    let postData = document.data()
                    let creator = postData["creator"] as? String ?? ""
                    //let creator = "creator"
                    let quote = postData["quote"] as? String ?? "(none)"
                    let imageURL = postData["image"] as? String ?? ""
                    let numLikes : Int = postData["likes"] as? Int ?? -1
                    //print("\(document.documentID) => \(document.data())")

                        scrollSize = scrollSize + 600
                        //creating the dummy stack view
                        //var y = (500 * index)
                        //y = y + 100 // this is to make sure that the next posts in the list appear under prev ones
                        let viewRec = CGRect(x: 0, y: CGFloat(y), width: self.scrollV.bounds.width, height: 500)
                        let stackV1 = UIView(frame: viewRec)
                        stackV1.backgroundColor = UIColor.systemGray6
                        // end of initializing stack view
                        
                        
                        scrollWidth = Int(self.scrollV.bounds.width)
                        
                        
                        //adding title lavel
                        let frameX = stackV1.bounds.origin.x
                        let frameY = stackV1.bounds.origin.y
                        let frameW = stackV1.bounds.width
                        let frameH = stackV1.bounds.height / 10;
                        let nameRec = CGRect(x: frameX, y: frameY, width: frameW, height: frameH)
                        let nameLabel = UILabel(frame: nameRec)
                        nameLabel.backgroundColor = UIColor.systemGray6
                        //nameLabel.text = "Test User 1"
                        nameLabel.text = creator

                        nameLabel.textAlignment = .center
                        stackV1.addSubview(nameLabel)
                        //end of adding a title
                        
                        //adding a picture
                        let picFrameX = frameX
                        let picFrameY = frameY + frameH
                        let picFrameW = frameW
                        let picFrameH = frameH * 5
                        let picRect = CGRect(x: picFrameX, y: picFrameY, width: picFrameW, height: picFrameH)
                        let pic = UIImageView(frame: picRect)
                     
                     //changes images
                     /*if( index % 2 == 0){
                        pic.image = UIImage(named: "postImage1")
                     }
                     else{
                         pic.image = UIImage(named: "postImage2")
                     }*/
                        //pic.image = image
              
                        //end of picture
                    let httpsReference = self.storage.reference(forURL: imageURL)
                        
                        //let imageRef = gsReference.child("IMG_1391.JPG")

                        httpsReference.getData(maxSize: 1 * 204800 * 204800) { data, error in
                          if let error = error {
                            // Uh-oh, an error occurred!
                           print("ERror: \(error)")
                          } else {
                            // Data for "images/island.jpg" is returned
                           print("Image before: \(image)")

                            if let stored = UIImage(data: data!) {
                                image = stored
                                pic.image = stored

                                print("Image: \(image)")
                            }
                            //image = UIImage(data: data!) ?? UIImage(named: "postImage1") as! UIImage
                          }
                        }
                    
                        stackV1.addSubview(pic)
                        
                        //adding a stack view to hold likes and number of likes
                        let sVFrameX = picFrameX
                        let sVFrameY = picFrameY + picFrameH
                        let sVFrameW = picFrameW
                        let sVFrameH = frameH
                        let lVRec = CGRect(x: sVFrameX, y: sVFrameY, width: sVFrameW, height: sVFrameH)
                        let likeView = UIView(frame: lVRec)
                        likeView.backgroundColor =  UIColor.systemGray6
                        
                        
                        
                        //setting up like button
                        
                        //let buttonFrame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)

                        //end of adding like button
                        
                        
                        //start words of aff
                        let wordsX = sVFrameX
                        let wordsY = sVFrameY
                        let wordsW = sVFrameW
                        let wordsH = frameH * 3
                        let wordsFrame = CGRect(x: wordsX, y: wordsY, width: wordsW, height: wordsH)
                        let wordsLabel = UILabel(frame: wordsFrame)
                        wordsLabel.text = quote
                        wordsLabel.numberOfLines = 0
                        wordsLabel.lineBreakMode = .byWordWrapping;
                         [wordsLabel.sizeToFit()]
                        stackV1.addSubview(wordsLabel)
                        //end words of aff
               
                    
                        
                        
                        
                        
                        y = y + 600
                    self.scrollV.addSubview(stackV1)
                        //print(scrollSize)
                    self.scrollV.contentSize = CGSize(width: scrollWidth, height: scrollSize)
                    }
                }
            }
        }

        //ViewController.swift

               //for index in 0...5{


               
    
    
    
    
    @objc func likePressed(sender: UIButton!) {
        print("like click");
        //handle functionaliy for updating like on screen and in data base
        //add boolean so that there can also be functionality for unliking something as well
        //we could think about how clicking on someones name will take you to their profile
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
