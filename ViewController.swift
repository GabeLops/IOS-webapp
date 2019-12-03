//
//  ViewController.swift
//  Project4_1
//
//  Created by Gabriel Lops on 11/29/19.
//  Copyright © 2019 Gabriel Lops. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com","hackingwithswift.com","u.gg","google.com"]
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
        //webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
  /*  @objc func openTapped() {
           let ac =  UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
           for website in websites {
              ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
               }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
               present(ac, animated: true)
    }*/
    
   

    
    /*/ override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                progressView.progress = Float(webView.estimatedProgress)
        }
    }*/
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           let url = navigationAction.request.url
           var urlAllowed = true
           
           if let host = url?.host {
               for website in websites {
                   if host.contains(website){
                       decisionHandler(.allow)
                       return
                   }else {urlAllowed = false}
               }
           }
           decisionHandler(.cancel)
           if urlAllowed == false {
               let blockedAC = UIAlertController(title: "Error", message: "This website is not allowed.", preferredStyle: .alert)
               blockedAC.addAction(UIAlertAction(title: "Continue", style: .default))
               present(blockedAC, animated: true)
           }
       }
   
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return websites.count
       }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites.sorted()[indexPath.row]
        return cell
       }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: "https://" + websites[indexPath.row]) else {return}
               if websites[indexPath.row] != "u.gg" {
                 
                 webView = WKWebView()
                 webView.navigationDelegate = self
                 
                 webView.load(URLRequest(url: url))
                 view = webView
             
               }else{
                   let stopLoad = UIAlertController(title: "Invalid Page", message: "The page you are trying to reach is blocked", preferredStyle: .alert)
                         stopLoad.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                   stopLoad.addAction(UIAlertAction(title: "Continue", style: .default))
                   present(stopLoad, animated: true)
                  
                   
               }
        
           
       
    }
   
}
