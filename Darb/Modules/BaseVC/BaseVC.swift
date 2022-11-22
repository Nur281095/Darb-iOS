//
//  BaseVC.swift
//  EyecareBrands
//
//  Created by Naveed ur Rehman on 26/08/2022.
//
import UIKit
import Loaf

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupDarkNav(){
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white as Any, NSAttributedString.Key.font: UIFont(name: AppFonts.roboto_medium, size: 25)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    func setupLightNav(){
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white as Any, NSAttributedString.Key.font: UIFont(name: AppFonts.roboto_medium, size: 25)!]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    func setupBlackNav(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hexString: "#2E284E")
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white as Any, NSAttributedString.Key.font: UIFont(name: AppFonts.roboto_medium, size: 25)!]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#17BDC8")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func setupClearNav(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .black.withAlphaComponent(0.1)
        
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black as Any, NSAttributedString.Key.font: UIFont(name: AppFonts.roboto_medium, size: 25)!]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    func setupWhiteNav(){
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#28769A") as Any, NSAttributedString.Key.font: UIFont(name: AppFonts.roboto_medium, size: 25)!]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#28769A")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setLeftAlignTitleView(font: UIFont, text: String, textColor: UIColor) {
        guard let navFrame = navigationController?.navigationBar.frame else{
            return
        }
        
        let parentView = UIView(frame: CGRect(x: 0, y: 0, width: navFrame.width*3, height: navFrame.height))
        self.navigationItem.titleView = parentView
        
        let label = UILabel(frame: .init(x: parentView.frame.minX, y: parentView.frame.minY, width: parentView.frame.width, height: parentView.frame.height))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = font
        label.textAlignment = .left
        label.textColor = textColor
        label.text = "  \(text)"
        
        parentView.addSubview(label)
    }
    func addLeftBarIcon(named: String) {

        let logoImage = UIImage.init(named: named)
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRect(x:0.0,y:0.0, width:113,height:35)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 113)
        let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 35)
         heightConstraint.isActive = true
         widthConstraint.isActive = true
         navigationItem.leftBarButtonItem =  imageItem
    }
    
    func btnLeft(image: String? = nil,text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var leftBtn: UIBarButtonItem!
        if text != nil {
            leftBtn = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnLeftAction(_:)))
        } else {
            leftBtn = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnLeftAction(_:)))
        }
        
        return leftBtn
    }
    
    @objc func btnLeftAction(_ sender: Any) {
        
    }
    func btnRight(image: String? = nil,text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var rightBtn: UIBarButtonItem!
        if text != nil {
            rightBtn = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnRightAction(_:)))
        } else {
            rightBtn = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnRightAction(_:)))
        }
        return rightBtn
    }
    
    @objc func btnRightAction(_ sender: Any) {
        
    }
    func btnLeft2(image: String? = nil, text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        
        var leftBtn2: UIBarButtonItem!
        if text != nil {
            leftBtn2 = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnLeftAction2(_:)))
        } else {
            leftBtn2 = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnLeftAction2(_:)))
        }
        return leftBtn2
    }
    
    @objc func btnLeftAction2(_ sender: Any) {
        
    }
    func btnRight2(image: String? = nil, text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var rightBtn2: UIBarButtonItem!
        if text != nil {
            rightBtn2 = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnRightAction2(_:)))
        } else {
            rightBtn2 = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnRightAction2(_:)))
        }
        return rightBtn2
    }
    
    @objc func btnRightAction2(_ sender: Any) {
        
    }
    
    func btnRight3(image: String? = nil, text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var rightBtn2: UIBarButtonItem!
        if text != nil {
            rightBtn2 = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnRightAction2(_:)))
        } else {
            rightBtn2 = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnRightAction3(_:)))
        }
        return rightBtn2
    }
    
    @objc func btnRightAction3(_ sender: Any) {
        
    }
    func btnUserImg(image: UIImage) -> UIBarButtonItem {

        let buttonWidth = CGFloat(30)
        let buttonHeight = CGFloat(30)

        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(btnUserImgAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        return UIBarButtonItem.init(customView: button)

    }
    
    @objc func btnUserImgAction(_ sender: Any) {
        
    }
    
    func btnLogo(image: UIImage) -> UIBarButtonItem {
        
        let buttonWidth = CGFloat(107)
        let buttonHeight = CGFloat(39)
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(btnLogoAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        return UIBarButtonItem.init(customView: button)

    }
    
    @objc func btnLogoAction(_ sender: Any) {
        
    }
    
    func btnImgTxt(image: String, text: String) -> UIBarButtonItem {
        
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(btnImgTxtAction(_:)), for: .touchUpInside)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: image)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 250, height: 30))
        label.text = text
        label.font =  UIFont(name: AppFonts.roboto, size: 12)
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 275, height: 30))
        button.frame = buttonView.frame
        buttonView.addSubview(button)
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        return UIBarButtonItem.init(customView: buttonView)

    }
    
    @objc func btnImgTxtAction(_ sender: Any) {
        
    }
    // MARK: Notification Bar Button Item
    func btnBack(isOrignal: Bool) -> UIBarButtonItem {
        
        let backBtn = UIBarButtonItem(image: isOrignal ? UIImage(named: "ic_back_white")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: "ic_back_white"), style: .plain, target: self, action: #selector(self.btnBackAction(_:)))
        return backBtn
    }
   
    @objc func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK: Notification Bar Button Item
    func btnWithCustomText(text: String) -> UIBarButtonItem {
        
        let txtBtn = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnCustomTextAction(_:)))
        return txtBtn
    }
    @objc func btnCustomTextAction(_ sender: Any) {
        
    }
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func goBackToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func goBackWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func goRootWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func navigateWithDelay(vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.pushViewController(vc, animated: true)
//            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func showTool(msg: String, state: Loaf.State) {
        Loaf(msg, state: state, sender: self).show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            Loaf.dismiss(sender: self, animated: true)
        }
    }

}
