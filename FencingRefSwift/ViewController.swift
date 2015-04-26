//
//  ViewController.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/19/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let phoneView = UINib(nibName: "iphone5", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView;
        //view = phoneView;
        
        let storyboard = UIStoryboard(name: "device4in", bundle: nil);
        let deviceVC = storyboard.instantiateViewControllerWithIdentifier("boutVC") as! UIViewController;
        var delegate:UIApplicationDelegate? = UIApplication.sharedApplication().delegate;
        delegate?.window??.rootViewController = deviceVC;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

