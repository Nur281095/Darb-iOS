//
//  SettingsVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 26/11/2022.
//

import UIKit

class SettingsVC: BaseVC {
    
    @IBOutlet weak var notSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Settings"
    }
    
    @IBAction func notSwitchChanged(_ sender: Any) {
        
    }
    
    
    @IBAction func changePassTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .more).loadViewController(withIdentifier: .changePassVC) as! ChangePassVC
        self.show(vc, sender: self)
    }
    
}
