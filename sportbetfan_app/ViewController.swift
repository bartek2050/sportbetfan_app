//
//  ViewController.swift
//  sportbetfan_app
//
//  Created by Bartek on 03/08/2021.
//

import UIKit
import WebKit
import SafariServices

//class LaunchViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.delay(1.0)
//    }
//
//    func delay(_ delay:Double, closure:@escaping ()->()) {
//        let when = DispatchTime.now() + delay
//        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
//    }
//}

class ViewController: UIViewController {
    
    
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://sport.betfan.pl/") else {
            return
        }
        webView.load(URLRequest(url: url))
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.webView.evaluateJavaScript("document.body.innerHTML") {
                result, error in guard let html = result as? String, error == nil else {
                    return
                }
            print(html)
            }
            
        }
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor(named: "betfanColor")
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(named: "betfanColor")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @IBAction func backBtn(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func home(_ sender: Any) {
        let url = URL(string: "https://sport.betfan.pl/")!
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func topBets(_ sender: Any) {
        let url = URL(string: "https://sport.betfan.pl/typowanie/")!
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func betfan(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://betfan.pl/zaklady-bukmacherskie")! as URL, options: [:], completionHandler: nil)
    }
    
}
