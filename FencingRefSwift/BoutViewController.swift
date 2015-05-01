//
//  BoutViewController.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/26/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation
import UIKit

class BoutViewController: UIViewController {
    
    /** Label displaying the current bout time */
    @IBOutlet weak var m_timerButton: UIButton!
    
    @IBOutlet weak var m_leftScoreBtn: UIButton!
    @IBOutlet weak var m_rightScoreBtn: UIButton!
    
    /** The active bout */
    var m_bout:Bout?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        m_bout = Bout(boutTime: 300, view: self);
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    // MARK: - User interaction
    
    /** Start running the bout timer */
    @IBAction func startTimer(sender: UIButton) {
        m_bout?.toggleTimer();
    }
    
    /** Score a touch for fencer on the left */
    @IBAction func scoreFencerLeft(sender: UIButton) {
        m_bout?.touchLeft();
    }
    
    /** Decrement the score of fencer on the left */
    @IBAction func decrementFencerLeft(sender: AnyObject) {
        
    }
    
    /** Score a touch for fencer on the right */
    @IBAction func scoreFencerRight(sender: UIButton) {
        m_bout?.touchRight();
    }
    
    /** Decrement the score of fencer on the right */
    @IBAction func decrementFencerRight(sender: UIButton) {
        
    }
    
    /** Score a touch for both fencers */
    @IBAction func scoreDoubleTouch(sender: UIButton) {
        m_bout?.touchDouble();
    }
    
    // MARK: - Calls from the Bout
    
    /**
    Sets the score for the fencer on the left
    
    :score: The score to set
    */
    func setLeftScore(score iScore:UInt8) {
        m_leftScoreBtn.titleLabel?.text = "\(iScore)";
    }
    
    /**
    Sets the score for the fencer on the right
    
    :score: The score to set
    */
    func setRightScore(score iScore:UInt8) {
        m_rightScoreBtn.titleLabel?.text = "\(iScore)";
    }
    
    /**
    Sets the current bout time
    
    :currentTime: The current time of the bout, in seconds
    */
    func setCurrentTime(currentTime fCurrentTime:Float) {
        m_timerButton.titleLabel?.text = Timer.getTimeString(timeInSeconds: fCurrentTime);
    }
    
    /** Alert the user with a buzz and sound */
    func alert() {
        
    }
}