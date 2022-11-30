//
//  EnrollmentListVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import StyledString
import SwiftyJSON

class EnrollmentListVC: BaseVC {
    
    @IBOutlet weak var colV: UICollectionView!
    
    
    var enrolls = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Enrollment Application"
        getEnrollList()
    }
    
    func getEnrollList() {
        self.enrolls.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "childs") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.enrolls.append(Child(fromDictionary: d))
                            }
                            if !self.enrolls.isEmpty {
//                                self.enrolls = self.enrolls.filter({$0.enrollementStatus != "unapplied"})
                            }
                        }
                        self.colV.reloadData()

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

extension EnrollmentListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enrolls.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 298)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnrollListCell", for: indexPath) as! EnrollListCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(12)
        }
        let str = StyledString("Processing").with(foregroundColor: UIColor(hexString: "#DF9401")).with(font: UIFont(name: AppFonts.roboto, size: 13)).with(backgroundColor: UIColor(hexString: "#FFC33E").withAlphaComponent(0.20))
        cell.statusBtn.setAttributedTitle(str.nsAttributedString, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(withName: .enrollment).loadViewController(withIdentifier: .enrollDetailVC) as! EnrollDetailVC
        vc.enroll = self.enrolls[indexPath.item]
        self.show(vc, sender: self)
    }
}
