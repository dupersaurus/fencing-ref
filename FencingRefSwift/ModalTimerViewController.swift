//
//  ModalTimerViewController.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 5/7/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation
import UIKit

class ModalTimerViewController : UIViewController {
    
    @IBOutlet weak var m_titleLabel: UILabel!
    @IBOutlet weak var m_timerLabel: UILabel!
    @IBOutlet weak var m_leftScoreLabel: UILabel!
    @IBOutlet weak var m_rightScoreLabel: UILabel!
    
    @IBOutlet weak var m_continueButton: UIButton!
    
    private var m_timer:Timer?;
    
    /** Method to call when stopping the timer */
    var m_cbClose:(Void->Void)?;
    
    override func viewDidLoad() {
        m_timer = Timer(countdownFrom: 0, withInterval: 0.1, tickCallback: onTimerTick, finishCallback: onTimerComplete);
        
        m_continueButton.layer.cornerRadius = 15;
    }
    
    func start(time fTime:NSTimeInterval, title sTitle:String, leftScore iLeftScore:UInt8, rightScore iRightScore:UInt8, onClose cbClose:(Void->Void)) {
        m_timer?.currentTime = fTime;
        m_timer?.start();
        m_cbClose = cbClose;
        
        m_titleLabel.text = sTitle;
        m_leftScoreLabel.text = String(iLeftScore);
        m_rightScoreLabel.text = String(iRightScore);
        m_timerLabel.text = Timer.getTimeString(timeInSeconds: fTime - 0.1);
    }
    
    func onTimerTick(fTime:NSTimeInterval) {
        m_timerLabel.text = Timer.getTimeString(timeInSeconds: fTime);
    }
    
    func onTimerComplete() {
        m_timerLabel.text = Timer.getTimeString(timeInSeconds: 0);
        //m_cbClose?();
    }
    
    @IBAction func stopTimer(gesture:UITapGestureRecognizer) {
        m_timer?.stop();
        m_cbClose?();
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}
