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
    var spinner = UIActivityIndicatorView()
    
    var collectedArray:Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webIns.service = self
        self.view.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.view.addSubview(first)
        self.addConstraints()
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
    
    func serviceDict(dict: Dictionary<AnyHashable, Any>) {
        spinner.stopAnimating()
        self.title = (dict["title"] as! String)
        collectedArray = parse.parseObj(dict: dict)
        first.collectedItems.delegate = self
        first.collectedItems.dataSource = self
        first.refressButton.addTarget(self, action: #selector(self.webCallInitiated), for: .touchDown)
    }
    
    @objc func webCallInitiated() {
        spinner.activityIndicatorViewStyle = .gray
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spinner)
        spinner.startAnimating()
        let x = NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let y = NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let width = NSLayoutConstraint(item: spinner, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0)
        let height = NSLayoutConstraint(item: spinner, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 0.5, constant: 0)
        self.view.addConstraints([x, y, width, height])
        webIns.webCall(webUrl: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


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
        let url = URL(string: obj.image!)
        cell?.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
        })
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

