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
    @IBOutlet weak var m_timerLabel: UILabel!
    
    /** Label with fotl's score */
    @IBOutlet weak var m_leftScoreLabel: UILabel!
    
    /** Label with fotr's score */
    @IBOutlet weak var m_rightScoreLabel: UILabel!
    
    /** Single-tap gesture for the timer */
    @IBOutlet var m_tapTimerGesture: UITapGestureRecognizer!
    
    /** Single-tap gesture for left score */
    @IBOutlet var m_tapLeftGesture: UITapGestureRecognizer!
    
    /** Single-tap gesture for right score */
    @IBOutlet var m_tapRightGesture: UITapGestureRecognizer!
    
    @IBOutlet var m_doubleTapLeftGesture: UITapGestureRecognizer!
    
    @IBOutlet var m_doubleTapRightGesture: UITapGestureRecognizer!
    /** The active bout */
    var m_bout:Bout?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        m_bout = Bout(boutTime: 15, view: self);
        
        /*m_timerLabel.addGestureRecognizer(m_tapTimerGesture);
        m_leftScoreLabel.addGestureRecognizer(m_tapLeftGesture);
        m_rightScoreLabel.addGestureRecognizer(m_tapRightGesture);*/
        
        m_timerLabel.userInteractionEnabled = true;
        m_leftScoreLabel.userInteractionEnabled = true;
        m_rightScoreLabel.userInteractionEnabled = true;
        
        m_tapLeftGesture.requireGestureRecognizerToFail(m_doubleTapLeftGesture);
        m_tapRightGesture.requireGestureRecognizerToFail(m_doubleTapRightGesture);
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    // MARK: - User interaction
    
    /** Start running the bout timer */
    @IBAction func toggleTimer(sender: UITapGestureRecognizer) {
        m_bout?.toggleTimer();
    }
    
    @IBAction func tapLeftScore(sender: UITapGestureRecognizer) {
        scoreFencerLeft();
    }
    
    @IBAction func tapRightScore(sender: UITapGestureRecognizer) {
        scoreFencerRight();
    }
    
    @IBAction func doubleTapLeftScore(sender: UITapGestureRecognizer) {
        m_bout?.reverseTouchLeft();
    }
    
    @IBAction func doubleTapRightScore(sender: UITapGestureRecognizer) {
        m_bout?.reverseTouchRight();
    }
    
    /** Score a touch for fencer on the left */
    func scoreFencerLeft() {
        m_bout?.touchLeft();
    }
    
    /** Decrement the score of fencer on the left */
    func decrementFencerLeft() {
        
    }
    
    /** Score a touch for fencer on the right */
    func scoreFencerRight() {
        m_bout?.touchRight();
    }
    
    /** Decrement the score of fencer on the right */
    func decrementFencerRight() {
        
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
        m_leftScoreLabel.text = "\(iScore)";
    }
    
    /**
    Sets the score for the fencer on the right
    
    :score: The score to set
    */
    func setRightScore(score iScore:UInt8) {
        m_rightScoreLabel.text = "\(iScore)";
    }
    
    /**
    Sets the current bout time
    
    :currentTime: The current time of the bout, in seconds
    */
    func setCurrentTime(currentTime fCurrentTime:Float) {
        m_timerLabel?.text = Timer.getTimeString(timeInSeconds: fCurrentTime);
    }
    
    /** Alert the user with a buzz and sound */
    func alert() {
        
    }
}