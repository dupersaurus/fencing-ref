//
//  CreateNewBoutView.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 5/10/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation
import UIKit

class CreateNewBoutView : UIViewController {
    
    private var m_vc:BoutViewController?;
    
    func setBoutVC(bvc:BoutViewController) {
        m_vc = bvc;
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    @IBAction func startPoolBout(sender: AnyObject) {
        createBoutType(Bout.self);
    }
    
    @IBAction func start15Touch(sender: AnyObject) {
        createBoutType(Bout15Touch.self);
    }
    
    @IBAction func start10Touch(sender: AnyObject) {
    
    }
    
    @IBAction func startFIETeam(sender: AnyObject) {
    
    }
    
    @IBAction func startNCAATeam(sender: AnyObject) {
    
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func viewDidLoad() {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    private func createBoutType(type:Bout.Type) {
        m_vc?.createNewBout(type);
        dismissViewControllerAnimated(true, completion: nil);
    }
}
