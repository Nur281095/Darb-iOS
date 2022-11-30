//
//  NotificationVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 21/11/2022.
//

import UIKit
import SwiftyJSON

class NotificationVC: BaseVC {

    @IBOutlet weak var tblV: UITableView!
    
    var notis = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Notifications"
        getNotis()
    }
    
    func getNotis() {
        self.notis.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "notifications") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.notis.append(NotificationModel(fromDictionary: d))
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

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notis.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotiCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(5)
        }
        cell.notTitle.text = notis[indexPath.row].title
        cell.descripLbl.text = notis[indexPath.row].descriptionField
        
        return cell
    }
}
