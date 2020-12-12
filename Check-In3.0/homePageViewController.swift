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
        //let pathReference = storage.reference(withPath: "posts/")
        let storageRef = storage.reference()
        //let imagesRef = storageRef.child("posts")
        let db = Firestore.firestore()
        //gs://check-in3.appspot.com/posts
        let gsReference = storage.reference(forURL: "gs://check-in3.appspot.com/")

        
        var scrollSize = 0
        var scrollWidth = 0
        var image = UIImage(named: "postImage1")
        var y = 0
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    var image = UIImage(named: "postImage1")
                    let postData = document.data()
                    let creator = postData["username"] as? String ?? ""
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
                        let imageRef = gsReference.child("IMG_1391.JPG")

                        imageRef.getData(maxSize: 1 * 204800 * 204800) { data, error in
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
                        let buttonX = likeView.bounds.origin.x
                        let buttonY = likeView.bounds.origin.y + 5
                        let buttonW = 60.0
                        let buttonH = 40.0
                        //let buttonFrame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
                        let buttonFrame = CGRect(x: buttonX, y: buttonY, width: CGFloat(buttonW), height: CGFloat(buttonH))
                        
                        let likeButton = UIButton(frame: buttonFrame)
                        let buttonImage = UIImage(named: "likeButton")
                        likeButton.setBackgroundImage(buttonImage, for: .normal)
                        likeButton.addTarget(self, action: #selector(self.likePressed), for: .touchUpInside)
                        likeView.addSubview(likeButton)
                        //end of adding like button
                        
                        //setting up the like number
                        let likeNumX = buttonX + CGFloat(buttonW) + 5
                        let likeNumY = buttonY
                        let likeNumW = 100.0
                        let likeNumH = 40.0
                        let numLikes = 1000000 //this will be changed to a value from the database
                        let likeFrame = CGRect(x: likeNumX, y: likeNumY, width: CGFloat(likeNumW), height: CGFloat(likeNumH))
                        let likeLabel = UILabel(frame: likeFrame )
                        likeLabel.text = String(numLikes)
                        likeView.addSubview(likeLabel)
                        // end of adding like num
                        stackV1.addSubview(likeView)
                        // end of like view
                        
                        //start words of aff
                        let wordsX = sVFrameX
                        let wordsY = sVFrameY + sVFrameH
                        let wordsW = sVFrameW
                        let wordsH = frameH * 3
                        let wordsFrame = CGRect(x: wordsX, y: wordsY, width: wordsW, height: wordsH)
                        let wordsLabel = UILabel(frame: wordsFrame)
                        wordsLabel.text = "test the words of aff to make sure that it works for this assignment and find a way to fill space"
                        wordsLabel.numberOfLines = 0
                        wordsLabel.lineBreakMode = .byWordWrapping;
                         [wordsLabel .sizeToFit()]
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
