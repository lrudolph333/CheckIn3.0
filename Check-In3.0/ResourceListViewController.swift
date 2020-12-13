//
//  ResourceListViewController.swift
//  Check-In3.0
//
//  Created by Oyin Sholeye on 12/11/20.
//  Copyright © 2020 Check-In. All rights reserved.
//

import UIKit


class ResourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resourceName: UILabel!
    
    @IBOutlet weak var resourceInfo: UILabel!
  
    
}


class ResourceListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
   
    var issuesArray:[String]! = []
    var resourceArray = [Resource]()
    var buttonClick = false;
    var sections:[String]! = []
    var doubleResource = [[Resource]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
            
        sectionsArray()
        tableView.delegate = self
        
        
    }
    func sectionsArray(){
            
            for i in 0 ..< sections.count{
                
                if(sections[i] == "sleep"){
                    sections[i] = "Sleep"
                }
                if(sections[i] == "academics"){
                    sections[i] = "Academics"
                }
                if(sections[i] == "anxiety"){
                    sections[i] = "Anxiety"
                }
                if(sections[i] == "depression"){
                    sections[i] = "Depression"
                }
                if(sections[i] == "general"){
                    sections[i] = "General"
                }
                if(sections[i] == "stress"){
                    sections[i] = "Stress"
                }
            }

      }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return doubleResource[section].count
    }

      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let tableCell:ResourceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResourceTableViewCell
       
      
//        let labelFrame = CGRect(x: 29, y: 57, width: tableCell.frame.width, height: 21)
//        tableCell.resourceInfo?.frame = labelFrame
        tableCell.resourceInfo?.numberOfLines = 0
        //tableCell.resourceInfo?.textColor = UIColor.blue
        tableCell.resourceInfo?.textAlignment = NSTextAlignment.center
       
        tableCell.resourceName?.textColor = UIColor.systemBlue
        tableCell.resourceName?.text = doubleResource[indexPath.section][indexPath.row].name!
        tableCell.resourceInfo?.text = doubleResource[indexPath.section][indexPath.row].information!
        
          return tableCell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openUrl(urlString: doubleResource[indexPath.section][indexPath.row].link!)
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string:urlString)
        UIApplication.shared.open((url)!)
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.systemTeal
        let head = view as! UITableViewHeaderFooterView
        head.textLabel?.textColor = UIColor.white
        
    }

}
