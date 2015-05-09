//
//  BoutTimerViewController.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 5/2/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation
import UIKit

class BoutTimerViewController : UIViewController {
    @IBOutlet weak var m_timerLabel: UILabel!
    
    /** Method to call to halt the bout */
    var m_cbHalt:(Void->Void)?;
    
    func setHaltCallback(callback:(Void->Void)) {
        m_cbHalt = callback;
    }
    
    func setBoutTime(fTime:Float) {
        m_timerLabel.text = Timer.getTimeString(timeInSeconds: fTime);
    }
    
    @IBAction func stopTimer(gesture:UITapGestureRecognizer) {
        m_cbHalt?();
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}