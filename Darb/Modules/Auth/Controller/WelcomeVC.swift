//
//  WelcomeVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit

class WelcomeVC: BaseVC {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
    

    @IBAction func welcomeTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .auth).loadViewController(withIdentifier: .signupVC) as! SignupVC
        self.show(vc, sender: self)
    }
    
    @IBAction func loginTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .auth).loadViewController(withIdentifier: .loginVC) as! LoginVC
        self.show(vc, sender: self)
    }
   
}
