//
//  UserProfileViewController.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var article: Artical?
    
    @IBOutlet weak var userLogo: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "User Profile"
        self.setUpUI()
        
    }
    
    func setUpUI() {
        self.fullNameLabel.text = "\(String(describing: article?.name)) \(String(describing: article?.lastname))"
        self.designationLabel.text = article?.designation
            self.cityLabel.text = article?.city
        self.userLogo.maskCircle(url: article?.avatar ?? "")
            self.aboutLabel.text = article?.about
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
