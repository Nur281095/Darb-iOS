//
//  ExploreVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit
import SwiftyJSON
import AAExtensions

class ExploreVC: BaseVC, SchoolFilterDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapsBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var colV: UICollectionView!
    @IBOutlet weak var search: UITextField!
    
     
    var schoolListModel = [SchoolListModel]()
    var filterSchoolList = [SchoolListModel]()
    var isfilter = false
    var params = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapsBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
        
        search.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        getSchoolList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .notificationVC) as! NotificationVC
        self.show(vc, sender: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if !textField.aa_isEmpty {
            isfilter = true
            filterSchoolList = schoolListModel.filter({$0.name.contains(textField.text!)})
        } else {
            isfilter = false
        }
        colV.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.aa_isEmpty {
            isfilter = true
            filterSchoolList = schoolListModel.filter({$0.name.contains(textField.text!)})
        } else {
            isfilter = false
        }
        colV.reloadData()
        textField.resignFirstResponder()
        return true
    }
    
    func getSchoolList() {
        isfilter = false
        self.schoolListModel.removeAll()
        if let loc = AppLocation.loc {
            params["lat"] = loc.latitude as AnyObject
            params["lang"] = loc.longitude as AnyObject
        }
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: params, method: "schools") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.schoolListModel.append(SchoolListModel(fromDictionary: d))
                            }
                        }
                        
                    } else {
                        self.showTool(msg: json["message"].string ?? "", state: .error)
                    }
                }
                self.colV.reloadData()
            }
            
        } fail: { response in
            Util.shared.hideSpinner()
            DispatchQueue.main.async {
                self.showTool(msg: response as? String ?? "Error", state: .error)
            }
        }
    }
    
    func didTapApply(params: [String : AnyObject]) {
        self.params = params
        self.getSchoolList()
    }
    
    @IBAction func mapTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .exploreMapVC) as! ExploreMapVC
        
        vc.schoolListModel = schoolListModel
        self.show(vc, sender: self)
    }
    @IBAction func filterTap(_ sender: Any) {
        
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolFilterVC) as! SchoolFilterVC
        vc.delegate = self
        self.show(vc, sender: self)
    }
}

extension ExploreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isfilter ? filterSchoolList.count : schoolListModel.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 238)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SchoolListCell", for: indexPath) as! SchoolListCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(12)
        }
        cell.configCell(model: isfilter ? filterSchoolList[indexPath.item] : schoolListModel[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolDetailVC) as! SchoolDetailVC
        vc.school = isfilter ? filterSchoolList[indexPath.item] : schoolListModel[indexPath.item]
        self.show(vc, sender: self)
    }
    
    
}

