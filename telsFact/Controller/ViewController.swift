//
//  ViewController.swift
//  sivarajexercise2
//
//  Created by Wipro on 22/06/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class ViewController: UIViewController,serviceCalls{
    let first = FirstView()
    let parse = parserClass()
    var obj = objectCollected()
    let webIns = WebService()
    var spinner : UIActivityIndicatorView!
    
    var collectedArray:Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webIns.service = self
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.webCallInitiated()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addConstraints() {
        first.translatesAutoresizingMaskIntoConstraints = false
        let x = NSLayoutConstraint(item: first, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let y = NSLayoutConstraint(item: first, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: first, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: first, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        self.view.addConstraints([x, y, width, height])
        
    }
    
    //protocol method
    
    func serviceDict(dict: Dictionary<AnyHashable, Any>) {
        self.title = (dict["title"] as! String)
        collectedArray = parse.parseObj(dict: dict)
        first.refressButton.addTarget(self, action: #selector(self.webCallInitiated), for: .touchDown)
        dismiss(animated: false, completion: nil)
        first.collectedItems.delegate = self
        first.collectedItems.dataSource = self
        self.view.addSubview(first)
        self.addConstraints()
    }
    
  
    
    
    
    @objc func webCallInitiated() {
        
  // Added Loading Alert
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
    // Web Call Initiated
        webIns.webCall(webUrl: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// TableView Delegates

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectedArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCell")
        }
        obj = (collectedArray[indexPath.row] as? objectCollected)!
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = obj.name
        cell?.textLabel?.numberOfLines = 0
        cell?.detailTextLabel?.text = obj.descrip
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.selectionStyle = .none
        let url = URL(string: obj.image!)
        // SdwebImage
        cell?.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
        })
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

