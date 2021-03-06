//
//  UserProfileViewController.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var article: Article?
    
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
        if let user = article?.user, user.count>0 {
            if let firstName = user[0].name, let lastName = user[0].lastname {
                self.fullNameLabel.text = "\(firstName) \(lastName)"

            }
            self.designationLabel.text = user[0].designation
            self.cityLabel.text = user[0].city
            self.userLogo.maskCircle(url: user[0].avatar ?? "",id: user[0].id ,entity: "Artical")
            self.aboutLabel.text = user[0].about
        }
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
