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
    
    @IBOutlet weak var m_periodLabel: UILabel!
    
    @IBOutlet weak var m_priorityTitle: UILabel!
    @IBOutlet weak var m_priorityLeft: UILabel!
    @IBOutlet weak var m_priorityRight: UILabel!
    
    @IBOutlet weak var m_fencingToLabel: UILabel!
    
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
    
    var m_timerModal:ModalTimerViewController?;
    
    var m_selectBoutModal:UIViewController?;
    @IBOutlet weak var m_newBoutView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //m_bout = Bout(vc: self);
        m_bout = Bout15Touch(vc: self);
        
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
        
        m_leftYellowCard.layer.cornerRadius = 5;
        m_leftRedCard.layer.cornerRadius = 5;
        m_rightYellowCard.layer.cornerRadius = 5;
        m_rightRedCard.layer.cornerRadius = 5;
        
        setPriorityDisplay(left: false, right: false);
        
        m_newBoutView.hidden = true;
        //m_newBoutView.center.y = view.bounds.height;
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
    
    @IBAction func manualPeriodBreak(sender: UIButton) {
        startPeriodBreak();
    }
    
    @IBAction func callMedicalTimeout(sender: UIButton) {
        startMedicalTimeout();
    }
    
    @IBAction func flipPriority(sender: AnyObject) {
        m_bout?.selectPriority();
    }
    
    @IBAction func giveYellowCardLeft(sender: UIButton) {
        m_bout?.cardLeft(Bout.Card.Yellow);
    }
    
    @IBAction func giveRedCardLeft(sender: UIButton) {
        m_bout?.cardLeft(Bout.Card.Red);
    }
    
    @IBAction func giveYellowCardRight(sender: UIButton) {
        m_bout?.cardRight(Bout.Card.Yellow);
    }
    
    @IBAction func giveRedCardRight(sender: UIButton) {
        m_bout?.cardRight(Bout.Card.Red);
    }
    
    @IBAction func startNewBout(sender: AnyObject) {
        if (m_selectBoutModal == nil) {
            m_selectBoutModal = self.storyboard!.instantiateViewControllerWithIdentifier("selectBout") as? UIViewController;
        }
        
        m_selectBoutModal!.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
        presentViewController(m_selectBoutModal!, animated: true, completion: nil);
        
        //m_newBoutView.hidden = false;
        
        /*UIView.transitionWithView(m_newBoutView, duration: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            }, completion: nil);*/
    }
    // MARK: - Input handlers
    
    func startTimer() {
        if (m_boutTimerModal == nil) {
            m_boutTimerModal = self.storyboard!.instantiateViewControllerWithIdentifier("runningTimer") as? BoutTimerViewController;
            m_boutTimerModal?.setHaltCallback(stopTimer);
        }
        
        presentViewController(m_boutTimerModal!, animated: false, completion: nil);
        
        m_bout?.start();
        m_boutTimerModal?.setBoutTime((m_bout?.currentTime)!);
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
    
    // MARK: - Control
    
    func startPeriodBreak() {
        startModalTimer(time: 60, title: "Period Break", onClose: onPeriodBreakClose);
    }
    
    func startMedicalTimeout() {
        startModalTimer(time: 600, title: "Medical Timeout", onClose: onMedicalTimerClose);
    }
    
    /** Start running the generic modal timer */
    func startModalTimer(time fTime:Float, title sTitle:String, onClose cbClose:(Void->Void)) {
        
        if m_timerModal == nil {
            m_timerModal = self.storyboard!.instantiateViewControllerWithIdentifier("modalTimer") as? ModalTimerViewController;
        }
        
        presentViewController(m_timerModal!, animated: false, completion: nil);
        m_timerModal?.start(time: fTime, title: sTitle, leftScore: (m_bout?.leftScore)!, rightScore: (m_bout?.rightScore)!, onClose: cbClose);
    }
    
    func onPeriodBreakClose() {
        dismissViewControllerAnimated(false, completion: nil);
        m_bout?.periodBreakComplete();
    }
    
    func onMedicalTimerClose() {
        dismissViewControllerAnimated(false, completion: nil);
    }
    
    private func setPriorityDisplay(left bLeft:Bool, right bRight:Bool) {
        if (bLeft || bRight) {
            m_priorityTitle.hidden = false;
            m_priorityLeft.hidden = !bLeft;
            m_priorityRight.hidden = !bRight;
            
        } else {
            m_priorityTitle.hidden = true;
            m_priorityLeft.hidden = true;
            m_priorityRight.hidden = true;
        }
    }
    
    /**
    Start a new bout using a given type
    
    :boutType: The type of bout to spawn
    */
    func createNewBout(boutType:AnyClass) {
        
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
    
    func setLeftCard(cardType:Bout.Card) {
        setCard(m_leftCurrentCard, card: cardType);
    }
    
    func setRightCard(cardType:Bout.Card) {
        setCard(m_rightCurrentCard, card: cardType);
    }
    
    private func setCard(cardDisplay:UIView, card:Bout.Card) {
        switch card {
            case .Yellow:
                cardDisplay.backgroundColor = UIColor.yellowColor();
            
            case .Red:
                cardDisplay.backgroundColor = UIColor.redColor();
            
            default:
                cardDisplay.backgroundColor = UIColor.blackColor();
        }
    }
    
    func setPeriodLabel(labelText sText:String) {
        m_periodLabel.text = sText;
    }
    
    /**
    Sets the current bout time
    
    :currentTime: The current time of the bout, in seconds
    */
    func setCurrentTime(currentTime fCurrentTime:Float) {
        m_timerLabel?.text = Timer.getTimeString(timeInSeconds: fCurrentTime);
        m_boutTimerModal?.setBoutTime(fCurrentTime);
    }
    
    /**
    Set the score the bout is being fenced to
    
    :score: The score the bout is being fenced to
    */
    func setFencingToScore(score iScore:UInt8) {
        m_fencingToLabel.text = "\(iScore)";
    }
    
    /**
    Set who has priority
    
    :forLeft: True to give priority to left, false to right
    */
    func setPriority(forLeft bLeft:Bool) {
        setPriorityDisplay(left: bLeft, right: !bLeft);
    }
    
    /** Clear the priority display */
    func clearPriority() {
        setPriorityDisplay(left: false, right: false);
    }
    
    /** Bout wants the user to select priority */
    func wantPriority(bWant:Bool) {
        
    }
    
    /** Alert the user with a buzz and sound */
    func alert() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}