//
//  HomeVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 17/11/2022.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var colV: UICollectionView!
    @IBOutlet weak var shadV3: UIView!
    @IBOutlet weak var shadV2: UIView!
    @IBOutlet weak var shadV: UIView!
    @IBOutlet weak var colH: NSLayoutConstraint! //210
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shadV.addShadow(10)
        shadV2.addShadow(10)
        shadV3.addShadow(10)
        self.navigationItem.leftBarButtonItem = btnLogo(image: UIImage(named: "homeNavLogo")!)
        self.navigationItem.rightBarButtonItem = btnRight(image: "ic_noti", isOrignal: true)
    }
    
    override func btnRightAction(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .notificationVC) as! NotificationVC
        self.show(vc, sender: self)
    }
    
    @IBAction func childrnTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .child).loadViewController(withIdentifier: .childernListVC) as! ChildernListVC
        self.show(vc, sender: self)
    }
    
    @IBAction func enrollTap(_ sender: Any) {
    }
    
    @IBAction func transportTap(_ sender: Any) {
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: 214)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnnouncementCell
        cell.setDescrip()
        DispatchQueue.main.async {
            cell.shadV.addShadow(10)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(withName: .home).loadViewController(withIdentifier: .annoucementDetailVC) as! AnnoucementDetailVC
        self.show(vc, sender: self)
    }
}
