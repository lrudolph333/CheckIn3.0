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
    var ref: DocumentReference? = nil
    var sleep = [Resource]()
    var academics = [Resource]()
    var depression = [Resource]()
    var stress = [Resource]()
    var anxiety = [Resource]()
    var general = [Resource]()
    var double = [[Resource]]()
    
    @IBOutlet weak var sleepBtn: UIButton!
    
    
    @IBOutlet weak var academicsBtn: UIButton!
    
    @IBOutlet weak var stressBtn: UIButton!
    
    @IBOutlet weak var anxietyBtn: UIButton!
    
   
    @IBOutlet weak var generalButton: UIButton!
    
    @IBOutlet weak var depressionBtn: UIButton!
    
    var sleepPick = false;
    var academicsPick = false;
    var stressPick = false;
    var anxietyPick = false;
    var depressionPick = false;
    var generalPick = false;
    let resourceView = ResourceViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSleepArray()
        setAnxietyArray()
        setAcademicArray()
        setSressArray()
        setDepressionArray()
        setGeneralArray()
    }
    
    
    
    @IBAction func sleepClick(_ sender: Any) {
        if(sleepPick == false){
            sleepBtn.backgroundColor = UIColor.systemGray5;
            resourceView.issues.append("sleep");
            sleepPick = true;
            
        }
        else if(sleepPick == true){
            sleepBtn.backgroundColor = UIColor.white;
            if let index = resourceView.issues.firstIndex(of: "sleep") {
                resourceView.issues.remove(at: index)
            }
            sleepPick = false;
        }
    }
    
    
    @IBAction func academicsClick(_ sender: Any) {
        if(academicsPick == false){
            academicsBtn.backgroundColor = UIColor.systemGray5;
            resourceView.issues.append("academics");
            academicsPick = true;
            
        }
        else if(academicsPick == true){
            academicsBtn.backgroundColor = UIColor.white;
            if let index = resourceView.issues.firstIndex(of: "academics") {
                resourceView.issues.remove(at: index)
            }
            academicsPick = false;
        }
    }
    
    
    @IBAction func stressClick(_ sender: Any) {
    if(stressPick == false){
        stressBtn.backgroundColor = UIColor.systemGray5;
        resourceView.issues.append("stress");
        stressPick = true;
        
    }
    else if(stressPick == true){
        stressBtn.backgroundColor = UIColor.white;
        if let index = resourceView.issues.firstIndex(of: "stress") {
            resourceView.issues.remove(at: index)
        }
        stressPick = false;
    }
    }
    
    @IBAction func anxietyClick(_ sender: Any) {
        if(anxietyPick == false){
            anxietyBtn.backgroundColor = UIColor.systemGray5;
            resourceView.issues.append("anxiety");
            anxietyPick = true;
            
        }
        else if(anxietyPick == true){
            anxietyBtn.backgroundColor = UIColor.white;
            if let index = resourceView.issues.firstIndex(of: "anxiety") {
                resourceView.issues.remove(at: index)
            }
            anxietyPick = false;
        }
    }
    
    @IBAction func depressionClick(_ sender: Any) {
        if(depressionPick == false){
            depressionBtn.backgroundColor = UIColor.systemGray5;
            resourceView.issues.append("depression");
            depressionPick = true;
           
        }
        else if(depressionPick == true){
            depressionBtn.backgroundColor = UIColor.white;
            if let index = resourceView.issues.firstIndex(of: "depression") {
                resourceView.issues.remove(at: index)
            }
            depressionPick = false;
        }

    }
 
    @IBAction func generalClick(_ sender: Any) {
        if(generalPick == false){
            generalButton.backgroundColor = UIColor.systemGray5;
            resourceView.issues.append("general");
            generalPick = true;
           
        }
        else if(generalPick == true){
            generalButton.backgroundColor = UIColor.white;
            if let index = resourceView.issues.firstIndex(of: "general") {
                resourceView.issues.remove(at: index)
            }
            generalPick = false;
        }
        
    }
    @IBAction func submitClick(_ sender: Any) {

    }
   
    func setSleepArray(){
        sleep.append(Resource(name: "Sleep Informational Flyer", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Sleep-Flyer-final.pdf", information: "Flyer containing information about healthy sleep"))
        
        
    }
    func setAnxietyArray(){
        anxiety.append(Resource(name: "Test & Performance Anxiety", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Test-and-Performance-Anxiety.pdf", information: "Anxiety is NOT the enemy. Moderate levels of anxiety can enhance our performance. However, too much anxiety can interfere with our ability to prepare and perform well."))
        anxiety.append(Resource(name: "Anxiety Health Information", link: "https://students.wustl.edu/anxiety-health-information/", information: "Health information on anxiety"))
        anxiety.append(Resource(name: "Counseling", link: "https://students.wustl.edu/counseling/", information: "Information on counseling at Washington University"))
        anxiety.append(Resource(name: "Mental Health Guidance for Managing Anxiety", link: "https://sites.wustl.edu/takingcare/", information: "Find information, resources, and strategies to help you manage your mental well-being "))
        }
    func setAcademicArray(){
        academics.append(Resource(name: "Procrastination Informational Flyer", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Procrastination.pdf", information: "Procrastination is more about unrealistic expectations,avoidance, coping with stress,or fear of failure."))
        academics.append(Resource(name: "Perfectionism Informational Flyer", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Perfectionism.pdf", information: "Strategies for Overcoming Perfectionism"))
        academics.append(Resource(name: "Academic Mentoring", link: "https://learningcenter.wustl.edu/academic-programs/help-with-courses/", information: "Matched mentoring provides supplemental learning."))
        academics.append(Resource(name: "Different Academic Programs", link: "https://learningcenter.wustl.edu/academic-programs/academic-program-types/", information: "Types of academic programs offered at The Learning Center"))
            
    }
    func setSressArray(){
        stress.append(Resource(name: "Stress Informational Flyer", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Stress.pdf", information: "Stress is a natural and inevitable part of life. Depending on how we deal with stress, it can help or hinder us. Our goal is to learn how to manage and harness stress."))
        stress.append(Resource(name: "Deep Breathing Flyer", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Deep-Breathing-Flyer.pdf", information: "TUNE IN.TAKE A STEP BACK.PAY ATTENTION."))
        stress.append(Resource(name: "Stress Management", link: "https://students.wustl.edu/stress-health-information/", information: "Get tips and resources for managing stress"))
        
    }
    func setDepressionArray(){
        depression.append(Resource(name: "Mindfulness", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Mindfulness.pdf", information: "PAUSE.NOTICE.REFLECT."))
        depression.append(Resource(name: "Mental Health Screening", link: "https://screening.mentalhealthscreening.org/wuhealth", information: "Self-evaluation for a depressive disorder"))
        depression.append(Resource(name: "Depression Health Information", link: "https://students.wustl.edu/depression-health-information/", information: ""))
        
            
    }
    func setGeneralArray(){
        general.append(Resource(name: "Mental Health Resources Card", link: "https://students.wustl.edu/wp-content/uploads/2020/09/WashU-Digital-Mental-Health-Resources-Card-to-save-to-your-phone.png", information: ""))
        general.append(Resource(name: "Mental Health Services Card", link:"https://students.wustl.edu/wp-content/uploads/2020/09/Mental-Health-Services-@-WashU.pdf", information: ""))
        general.append(Resource(name: "Mental Health Referral Decision Tree", link: "https://students.wustl.edu/wp-content/uploads/2020/11/Mental-Health-Referral-Decision-Tree-1.pdf", information: ""))
        general.append(Resource(name: "Isolation Wellbeing Plan", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Isolation-Wellbeing-Plan.pdf", information: ""))
        general.append(Resource(name: "Quarantine Wellbeing Plan", link: "https://students.wustl.edu/wp-content/uploads/2020/09/Quarantine-Wellbeing-Plan.pdf", information: ""))
        
    }
        
    func setArray(){
            
            
              for x in 0 ..< resourceView.issues.count {
                   
                if(resourceView.issues[x] == "sleep"){
                    for i in 0 ..< sleep.count {
                        resourceView.resources.append(sleep[i])
                              
                    }
                    double.append(sleep)
                   
                }
                if(resourceView.issues[x] == "academics"){
                    for i in 0 ..< academics.count {
                        resourceView.resources.append(academics[i]);
                    }
                    double.append(academics)
                  
                }
                if(resourceView.issues[x] == "depression"){
                    for i in 0 ..< depression.count {
                        resourceView.resources.append(depression[i]);
                    }
                    double.append(depression)
                }
                if(resourceView.issues[x] == "anxiety"){
                     for i in 0 ..< anxiety.count {
                        resourceView.resources.append(anxiety[i]);
                    }
                     double.append(anxiety)
                }
                if(resourceView.issues[x] == "stress"){
                    for i in 0 ..< stress.count {
                        resourceView.resources.append(stress[i]);
                    }
                    double.append(stress)
                }
                if(resourceView.issues[x] == "general"){
                    for i in 0 ..< general.count {
                        resourceView.resources.append(general[i]);
                    }
                    double.append(general)
                }
                
                
            }
        
        }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        resourceView.resources.removeAll()
        double.removeAll()
        setArray()
        if let vc = segue.destination as? ResourceListViewController
        {
           
            for i in 0 ..< resourceView.resources.count{
                
                vc.resourceArray.append(resourceView.resources[i])
            }
            for i in 0 ..< resourceView.issues.count{
                vc.sections.append(resourceView.issues[i])
            }
            
            vc.doubleResource = double
            
        
        }
        
    }


}
