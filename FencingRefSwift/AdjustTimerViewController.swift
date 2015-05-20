//
//  AdjustTimerViewController.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 5/19/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation
import UIKit

class AdjustTimerViewController : UIViewController {
    @IBOutlet weak var m_minuteStepper: UIStepper!
    @IBOutlet weak var m_secondStepper: UIStepper!
    @IBOutlet weak var m_timeLabel: UILabel!
    
    private var m_boutVC:BoutViewController?;
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func viewDidLoad() {
        m_minuteStepper.layer.cornerRadius = 5;
        m_secondStepper.layer.cornerRadius = 5;
    }
    
    /** Set the vc up with a beginning time */
    func setup(currentTime fTime:Float, bout:BoutViewController) {
        
        m_boutVC = bout;
        m_timeLabel.text = Timer.getTimeString(timeInSeconds: fTime);
        
        m_minuteStepper.value = Double(floor(fTime / 60));
        m_secondStepper.value = Double(fTime % 60);
    }
    
    @IBAction func onClose(sender: AnyObject) {
        m_boutVC?.setBoutTime(newTime: getTimeInSeconds());
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    @IBAction func onMinuteStep(sender: UIStepper) {
        m_timeLabel.text = Timer.getTimeString(timeInSeconds: getTimeInSeconds());
    }

    @IBAction func onSecondStep(sender: UIStepper) {
        m_timeLabel.text = Timer.getTimeString(timeInSeconds: getTimeInSeconds());
    }
    
    private func getTimeInSeconds() -> Float {
        return Float(m_minuteStepper.value * 60 + m_secondStepper.value);
    }
}