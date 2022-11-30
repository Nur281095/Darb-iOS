//
//  HomeVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit
import SwiftyJSON

class HomeVC: BaseVC {

    @IBOutlet weak var noAnn: UILabel!
    @IBOutlet weak var colV: UICollectionView!
    @IBOutlet weak var shadV3: UIView!
    @IBOutlet weak var shadV2: UIView!
    @IBOutlet weak var shadV: UIView!
    @IBOutlet weak var colH: NSLayoutConstraint! //210
    
    var announcements = [AnnouncementModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noAnn.isHidden = true
        shadV.addShadow(10)
        shadV2.addShadow(10)
        shadV3.addShadow(10)
        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
        if Util.getUser() != nil {
            getProfile()
            getAnnouncments()
        }
    }
    
    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .notificationVC) as! NotificationVC
        self.show(vc, sender: self)
    }
    
    func getProfile() {
        DispatchQueue.background {
            ALF.shared.doGetData(parameters: [:], method: "auth/update_profile") { response in
                print(response)
                DispatchQueue.main.async {
                    let json = JSON(response)
                    if let status = json["status_code"].int {
                        if statusRange.contains(status) {
                            if var user = json["data"].dictionaryObject {
                                let token = Util.getUser()!.apiToken
                                user["api_token"] = token
                                if let usrStr = user.aa_json {
                                    UserDefaults.standard.set(usrStr, forKey: "user")
                                }
                            }
                        }
                    }
                }
            } fail: { response in
                
            }

        } completion: {
            
        }

    }
    
    func getAnnouncments() {
        self.announcements.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "announcements") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.announcements.append(AnnouncementModel(fromDictionary: d))
                            }
                        }
                        self.colV.reloadData()
                        self.noAnn.isHidden = !self.announcements.isEmpty
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
    
    @IBAction func childrnTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .child).loadViewController(withIdentifier: .childernListVC) as! ChildernListVC
        self.show(vc, sender: self)
    }
    
    @IBAction func enrollTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .enrollment).loadViewController(withIdentifier: .enrollmentListVC) as! EnrollmentListVC
        self.show(vc, sender: self)
    }
    
    @IBAction func transportTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .transport).loadViewController(withIdentifier: .transportListVC) as! TransportListVC
        self.show(vc, sender: self)
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcements.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: 214)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnnouncementCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(10)
        }
        let model = announcements[indexPath.item]
        cell.setDescrip(model: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .annoucementDetailVC) as! AnnoucementDetailVC
        self.show(vc, sender: self)
    }
}
