//
//  ProfileVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit

class ProfileVC: BaseVC {
    
    @IBOutlet weak var nameLbls: UILabel!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Profile"
    }
    
    @IBAction func updateTap(_ sender: Any) {
        self.resignAll()
    }
    
    

}
