//
//  MoreVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit

class MoreVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
    }
    

    @IBAction func menuBtnTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            //profile
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .profileVC) as! ProfileVC
            self.show(vc, sender: self)
        case 1:
            //setting
            break
        case 2:
            //About App
            break
        case 3:
            //Support
            break
        case 4:
            //Privacy Policy
            break
        case 5:
            //Terms and Conditions
            break
        case 6:
            //Logout
            break
        default:
            break
        }
    }
    

}
