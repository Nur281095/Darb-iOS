//
//  ResetPassVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 19/11/2022.
//

import UIKit
import SwiftyJSON

class ResetPassVC: BaseVC {

    @IBOutlet weak var newPassTxt: UITextField!
    @IBOutlet weak var conPassTxt: UITextField!
    
    var resetToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func continueTap(_ sender: Any) {
        self.resignAll()
        let passValid = Validator.validatePassword(text: newPassTxt.text)
        if !passValid.0 {
            print(passValid.1)
            self.showTool(msg: passValid.1, state: .error)
            return
        }
        
        if newPassTxt.text != conPassTxt.text {
            self.showTool(msg: "Password doesn't match", state: .error)
            return
        }
             
        
        var dic = Dictionary<String, AnyObject>()
        dic["password"] = newPassTxt.text as AnyObject
        dic["password_confirmation"] = conPassTxt.text as AnyObject
        dic["token"] = resetToken as AnyObject
       
        print(dic)
        Util.shared.showSpinner()
        ALF.shared.doPostData(parameters: dic, method: "auth/reset_password") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        self.showTool(msg: json["message"].string ?? "Password Reset Successfully", state: .success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.goBackToRoot()
                        }
                    } else {
                        self.showTool(msg: json["message"].string ?? "", state: .error)
                    }
                }
            }
            
        } fail: { response in
            Util.shared.hideSpinner()
            DispatchQueue.main.async {
                self.showTool(msg: response as? String ?? "Error", state: .error)
            }
        }
        
    }
    

}
