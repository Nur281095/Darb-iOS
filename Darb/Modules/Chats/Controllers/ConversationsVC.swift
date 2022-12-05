//
//  ConversationsVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit
import SwiftyJSON

class ConversationsVC: BaseVC {
    
    @IBOutlet weak var tblV: UITableView!
    
    
    var conversations = [ConversationsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getConversations()
    }
    
    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .notificationVC) as! NotificationVC
        self.show(vc, sender: self)
    }
    func getConversations() {
        self.conversations.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "getAllConversation") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.conversations.append(ConversationsModel(fromDictionary: d))
                            }
                        }
                        self.tblV.reloadData()

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

extension ConversationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ConversationCell
        let model = conversations[indexPath.row]
        
        let usr = Util.getUser()!
        if model.sender.id != usr.id {
            let name = "\(model.sender.firstName ?? "") \(model.sender.lastName ?? "")"
            cell.name.text = name
            cell.naameLbls.text = name.getAcronyms().uppercased()
        } else if model.receiver.id != usr.id {
            let name = "\(model.receiver.firstName ?? "") \(model.receiver.lastName ?? "")"
            cell.name.text = name
            if name.count > 2 {
                let newName = String(name.getAcronyms().prefix(2))
                cell.naameLbls.text = newName.uppercased()
            } else {
                cell.naameLbls.text = name.getAcronyms().uppercased()
            }
            
        }
        let dateStr = model.createdAt.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "yyyy-MM-dd HH:mm:ss").aa_toDate(fromFormat: "yyyy-MM-dd HH:mm:ss", currentTimeZone: true)?.aa_timeAgo(numericDates: true)
        if model.message.count > 15 {
            let str = model.message
            let result = String(str!.prefix(15))
            cell.msgTimeLbl.text = "\(result)... : \(dateStr ?? "")"
        } else{
            cell.msgTimeLbl.text = "\(model.message ?? "") : \(dateStr ?? "")"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = conversations[indexPath.row]
        let usr = Util.getUser()!
        var name = ""
        let vc = UIStoryboard.storyBoard(withName: .chat).loadViewController(withIdentifier: .chatVC) as! ChatVC
        if usr.id != model.sender.id {
            vc.schoolID = model.sender.id
            name = "\(model.sender.firstName ?? "") \(model.sender.lastName ?? "")"
        } else if usr.id != model.receiver.id {
            vc.schoolID = model.receiver.id
            name = "\(model.receiver.firstName ?? "") \(model.receiver.lastName ?? "")"
        }
        vc.otherName = name
        self.show(vc, sender: self)
    }
}
