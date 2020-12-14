//
//  navViewController.swift
//  Check-In3.0
//
//  Created by Arric Lucas on 12/14/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit

class navViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.isNavigationBarHidden = true;
        
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
