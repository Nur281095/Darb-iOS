//
//  MoreVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit
import AAExtensions

class MoreVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
    }
    
    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .notificationVC) as! NotificationVC
        self.show(vc, sender: self)
    }

    @IBAction func menuBtnTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            //profile
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .profileVC) as! ProfileVC
            self.show(vc, sender: self)
        case 1:
            //setting
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .settingsVC) as! SettingsVC
            self.show(vc, sender: self)
        case 2:
            //About App
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .webVC) as! WebVC
            vc.navTitle = "About App"
            vc.file = "about"
            self.show(vc, sender: self)
        case 3:
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .supoortVC) as! SupoortVC
            self.show(vc, sender: self)
        case 4:
            //Privacy Policy
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .webVC) as! WebVC
            vc.navTitle = "Privacy Policy"
            vc.file = "Privacy"
            self.show(vc, sender: self)
        case 5:
            //Terms and Conditions
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .webVC) as! WebVC
            vc.navTitle = "Terms and Conditions"
            vc.file = "terms"
            self.show(vc, sender: self)
        case 6:
            //Logout
            self.aa_showAlertCustom(Appname, text: "Are you sure to logout from the application?", onDismiss: {
                Util.logout()
            }, onCancel:  {
                
            })
        default:
            break
        }
    }
    

}
