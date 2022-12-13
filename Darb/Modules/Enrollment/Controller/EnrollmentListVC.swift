//
//  EnrollmentListVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import StyledString
import SwiftyJSON
import AAExtensions

class EnrollmentListVC: BaseVC {
    
    @IBOutlet weak var colV: UICollectionView!
    
    
    var enrolls = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Enrollment Application"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enrolls.removeAll()
        colV.reloadData()
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
                            self.enrolls = self.enrolls.filter({$0.enrollementStatus != "unapplied"})
                            if self.enrolls.isEmpty {
//                                self.enrolls = self.enrolls.filter({$0.enrollementStatus != "unapplied"})
                                self.showTool(msg: "No enrollment found", state: .warning)
                                self.goBackWithDelay()
                            } else {
                                self.colV.reloadData()
                            }
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
        let model = self.enrolls[indexPath.item]
        let str = StyledString("Processing").with(foregroundColor: UIColor(hexString: "#DF9401")).with(font: UIFont(name: AppFonts.roboto, size: 13)).with(backgroundColor: UIColor(hexString: "#FFC33E").withAlphaComponent(0.20))
        cell.statusBtn.setAttributedTitle(str.nsAttributedString, for: .normal)

        let name = "\(model.firstName ?? "") \(model.lastName ?? "")"
        cell.name.text = name
        cell.nameLbls.text = name.getAcronyms().uppercased()
        cell.grade.text = model.grade.gradeName
        cell.schlName.text = model.school.name
        if !model.school.gallery.isEmpty {
            cell.image.sd_setImage(with: URL(string: model.school.gallery[0].name)!)
        } else {
            cell.image.image = nil
        }
        cell.address.text = model.school.location
        cell.statusBtn.setTitle(model.enrollementStatus.capitalized, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(withName: .enrollment).loadViewController(withIdentifier: .enrollDetailVC) as! EnrollDetailVC
        vc.enroll = self.enrolls[indexPath.item]
        self.show(vc, sender: self)
    }
}
