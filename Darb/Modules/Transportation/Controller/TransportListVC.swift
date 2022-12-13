//
//  TransportListVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit
import SwiftyJSON

class TransportListVC: BaseVC {

    @IBOutlet weak var colV: UICollectionView!
    
    
    var transports = [TransportModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Transportation"        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTranportList()
    }
    

    func getTranportList() {
        self.transports.removeAll()
        Util.shared.showSpinner()
        ALF.shared.doGetData(parameters: [:], method: "transportations") { response in
            Util.shared.hideSpinner()
            print(response)
            DispatchQueue.main.async {
                let json = JSON(response)
                if let status = json["status_code"].int {
                    if statusRange.contains(status) {
                        if let data = response["data"] as? [[String: Any]] {
                            for d in data {
                                self.transports.append(TransportModel(fromDictionary: d))
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
    
    @IBAction func addMoreTap(_ sender: UIButton) {
        let vc = UIStoryboard.storyBoard(withName: .transport).loadViewController(withIdentifier: .transportVC) as! TransportVC
        self.show(vc, sender: self)
    }

}

extension TransportListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transports.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 162)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TransportListCell
        DispatchQueue.main.async {
            cell.shadV.addShadow(12)
        }
        let model = transports[indexPath.item]
        cell.fromToDescrip.attributedText = cell.setDescrip(model: model)
        cell.statusBtn.setTitle(model.status.capitalized, for: .normal)
        cell.schoolName.text = model.schoolName
        return cell
    }
}
