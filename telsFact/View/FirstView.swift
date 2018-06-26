//
//  FirstView.swift
//  sivarajexercise2
//
//  Created by Wipro on 22/06/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class FirstView: UIView {
    var collectedItems = UITableView()
    var refressButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Table View
        self.backgroundColor = UIColor.black
       // collectedItems.style == UITableViewStyle.plain
        collectedItems.backgroundColor = UIColor.white
        self.addSubview(collectedItems)
        collectedItems.translatesAutoresizingMaskIntoConstraints = false
        let x = NSLayoutConstraint(item: collectedItems, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let y = NSLayoutConstraint(item: collectedItems, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: collectedItems, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: collectedItems, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 0.90, constant: 0)
        self.addConstraints([x, y, width, height])
       
        // Refreh button
        
        refressButton.buttonType == UIButtonType.custom
        refressButton.setTitle("Refresh", for: UIControlState.normal)
        refressButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        refressButton.backgroundColor = UIColor.black
        self.addSubview(refressButton)
        refressButton.translatesAutoresizingMaskIntoConstraints = false
        let buttx = NSLayoutConstraint(item: refressButton, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let butty = NSLayoutConstraint(item: refressButton, attribute: .top, relatedBy: .equal, toItem:collectedItems, attribute: .bottomMargin, multiplier: 1.0, constant: 10)
        let buttwidth = NSLayoutConstraint(item: refressButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        let buttheight = NSLayoutConstraint(item:refressButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.10, constant: 0)
        self.addConstraints([buttx, butty, buttwidth, buttheight])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
