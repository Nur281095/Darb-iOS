//
//  WebVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 11/12/2022.
//

import UIKit
import WebKit

class WebVC: BaseVC, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    
    var navTitle = ""
    var file = ""
    private var estimatedProgressObserver: NSKeyValueObservation?
    let progressView = UIProgressView(progressViewStyle: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = navTitle
        webView.navigationDelegate = self
        
        setupProgressView()
        setupEstimatedProgressObserver()
        
        if let pdfURL = Bundle.main.url(forResource: file, withExtension: "pdf", subdirectory: nil, localization: nil)  {
            do {
                let data = try Data(contentsOf: pdfURL)
                webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
            }
            catch {
                // catch errors here
            }
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        progressView.progress = 0
        self.progressView.alpha = 0.0
        progressView.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    // MARK: - Private methods
    private func setupProgressView() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        progressView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressView)

        progressView.isHidden = true
        progressView.tintColor = UIColor.blue
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),

            progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }

    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        if progressView.isHidden {
            // Make sure our animation is visible.
            progressView.isHidden = false
        }

        UIView.animate(withDuration: 0.33,
                       animations: {
                           self.progressView.alpha = 1.0
        })
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
//        webView.evaluateJavaScript("document.getElementsByTagName('p')[0].innerHTML", completionHandler: { (res, error) in
//             if let fingerprint = res {
//                  // Fingerprint will be a string of JSON. Parse here...
//                  print(fingerprint)
//             }
//        })
     
        webView.evaluateJavaScript("document.getElementById('response').getAttribute('data-content')", completionHandler: { (res, error) in
             if let fingerprint = res as? String {
                if let json = self.convertStringToDictionary(text: fingerprint) {
                    print(json)
                    if let action_type = json["action_type"] as? String {
                        if var str = json["message"] as? String {
                            str = str.replacingOccurrences(of: "%20", with: " ")
                            str = str.replacingOccurrences(of: "%2C", with: ".")
//                            if action_type == "cancel" {
                                self.aa_showAlert(Appname, text: str, doneText: "Go Back") {
                                    self.goBack()
                                }
//                            } else if action_type == "success" {
//                                self.aa_showAlert(Appname, text: str, doneText: "") {
//
//                                }
//                            }
                            
                        }
                        
                    }
                    
                    
                }
//                if let json = fingerprint.parseJSONString as? Dictionary<String,AnyObject> {
//
//                }
                
             }
        })
        UIView.animate(withDuration: 0.33,
                       animations: {
                           self.progressView.alpha = 0.0
                       },
                       completion: { isFinished in
                           // Update `isHidden` flag accordingly:
                           //  - set to `true` in case animation was completly finished.
                           //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
                           self.progressView.isHidden = isFinished
        })
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print(error.localizedDescription)
                print("Something went wrong")
            }
        }
        return nil
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        UIView.animate(withDuration: 0.33,
                       animations: {
                           self.progressView.alpha = 0.0
                       },
                       completion: { isFinished in
                           // Update `isHidden` flag accordingly:
                           //  - set to `true` in case animation was completly finished.
                           //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
                           self.progressView.isHidden = isFinished
        })
    }
    
}
