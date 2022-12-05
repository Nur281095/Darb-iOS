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
            break
        case 2:
            //About App
            break
        case 3:
            let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .supoortVC) as! SupoortVC
            self.show(vc, sender: self)
        case 4:
            //Privacy Policy
            break
        case 5:
            //Terms and Conditions
            break
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
