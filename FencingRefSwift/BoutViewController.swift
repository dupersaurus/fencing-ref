//
//  BoutViewController.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/26/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class BoutViewController: UIViewController {
    
    /** Label displaying the current bout time */
    @IBOutlet weak var m_timerLabel: UILabel!
    
    /** Label with fotl's score */
    @IBOutlet weak var m_leftScoreLabel: UILabel!
    
    /** Label with fotr's score */
    @IBOutlet weak var m_rightScoreLabel: UILabel!
    
    @IBOutlet weak var m_leftYellowCard: UIButton!
    @IBOutlet weak var m_leftRedCard: UIButton!
    @IBOutlet weak var m_leftCurrentCard: UIView!
    
    @IBOutlet weak var m_rightYellowCard: UIButton!
    @IBOutlet weak var m_rightRedCard: UIButton!
    @IBOutlet weak var m_rightCurrentCard: UIView!
    
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
    
    /** The modal screen used when running the timer */
    var m_boutTimerModal:BoutTimerViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        m_bout = Bout(boutTime: 180, view: self);
        
        /*m_timerLabel.addGestureRecognizer(m_tapTimerGesture);
        m_leftScoreLabel.addGestureRecognizer(m_tapLeftGesture);
        m_rightScoreLabel.addGestureRecognizer(m_tapRightGesture);*/
        
        m_timerLabel.userInteractionEnabled = true;
        m_leftScoreLabel.userInteractionEnabled = true;
        m_rightScoreLabel.userInteractionEnabled = true;
        
        m_tapLeftGesture.requireGestureRecognizerToFail(m_doubleTapLeftGesture);
        m_tapRightGesture.requireGestureRecognizerToFail(m_doubleTapRightGesture);
        
        m_leftCurrentCard.layer.borderColor = UIColor.whiteColor().CGColor;
        m_leftCurrentCard.layer.borderWidth = 1;
        m_leftCurrentCard.layer.cornerRadius = 5;
        m_rightCurrentCard.layer.borderColor = UIColor.whiteColor().CGColor;
        m_rightCurrentCard.layer.borderWidth = 1;
        m_rightCurrentCard.layer.cornerRadius = 5;
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    // MARK: - View controller interface
    
    /** Start running the bout timer */
    @IBAction func toggleTimer(sender: UITapGestureRecognizer) {
        startTimer();
    }
    
    @IBAction func tapLeftScore(sender: UITapGestureRecognizer) {
        scoreFencerLeft();
    }
    
    @IBAction func tapRightScore(sender: UITapGestureRecognizer) {
        scoreFencerRight();
    }
    
    @IBAction func doubleTapLeftScore(sender: UITapGestureRecognizer) {
        decrementFencerLeft();
    }
    
    @IBAction func doubleTapRightScore(sender: UITapGestureRecognizer) {
        decrementFencerRight();
    }
    
    /** Score a touch for both fencers */
    @IBAction func tapDoubleTouch(sender: UIButton) {
        scoreDoubleTouch();
    }
    
    @IBAction func resetBout(sender: UIButton) {
        resetCurrentBout();
    }
    
    // MARK: - Input handlers
    
    func startTimer() {
        if (m_boutTimerModal == nil) {
            m_boutTimerModal = self.storyboard!.instantiateViewControllerWithIdentifier("runningTimer") as? BoutTimerViewController;
            m_boutTimerModal?.setHaltCallback(stopTimer);
        }
        
        presentViewController(m_boutTimerModal!, animated: false, completion: nil);
        
        m_bout?.start();
        alert();
    }
    
    func stopTimer() {
        dismissViewControllerAnimated(false, completion: nil);
        
        m_bout?.halt();
        alert();
    }
    
    /** Score a touch for fencer on the left */
    func scoreFencerLeft() {
        m_bout?.touchLeft();
        alert();
    }
    
    /** Decrement the score of fencer on the left */
    func decrementFencerLeft() {
        m_bout?.reverseTouchLeft();
    }
    
    /** Score a touch for fencer on the right */
    func scoreFencerRight() {
        m_bout?.touchRight();
        alert();
    }
    
    /** Decrement the score of fencer on the right */
    func decrementFencerRight() {
        m_bout?.reverseTouchRight();
    }
    
    func scoreDoubleTouch() {
        m_bout?.touchDouble();
        alert();
    }
    
    func resetCurrentBout() {
        m_bout?.resetToDefault();
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
        m_boutTimerModal?.setBoutTime(fCurrentTime);
    }
    
    /** Alert the user with a buzz and sound */
    func alert() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}