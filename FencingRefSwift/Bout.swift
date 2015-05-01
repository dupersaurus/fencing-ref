//
//  Bout.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/19/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation

/** The main manager of a bout. */
public class Bout {
    
    struct BoutEvent {
        var m_time:Float;
        var m_leftScore:UInt8;
        var m_rightScore:UInt8;
        var m_sMessage:String;
        
        init(time:Float, leftScore:UInt8, rightScore:UInt8, sMessage:String) {
            m_time = time;
            m_leftScore = leftScore;
            m_rightScore = rightScore;
            m_sMessage = sMessage;
        }
    }
    
    var m_boutEvents:[BoutEvent];
    
    var m_viewController:BoutViewController;
    
    /** The score for the fencer on the left */
    var m_iLeftScore:UInt8
    
    /** The score for the fencer on the right */
    var m_iRightScore:UInt8
    
    /** The current period */
    var m_iPeriod:UInt8;
    
    /** The bout timer */
    var m_timer:Timer?;
    
    init(boutTime fTime:Float, view vc:BoutViewController) {
        m_viewController = vc;
        m_iLeftScore = 0;
        m_iRightScore = 0;
        m_iPeriod = 1;
        m_boutEvents = [BoutEvent]();
        
        m_timer = Timer(countdownFrom: fTime, withInterval: 0.1, tickCallback: onTimerTick, finishCallback: onTimerFinish);
        
        vc.setCurrentTime(currentTime: fTime);
        vc.setLeftScore(score: 0);
        vc.setRightScore(score: 0);
    }
    
    /** Begin running the timer */
    public func start() {
        m_timer?.start();
    }
    
    /** Stop the timer */
    public func halt() {
        m_timer?.stop();
    }
    
    public func toggleTimer() {
        if m_timer!.isRunning() {
            m_timer?.stop();
        } else {
            m_timer?.start();
        }
    }
    
    /** 
    Score touch for fencer on the left
    */
    public func touchLeft() {
        m_iLeftScore++;
        m_viewController.setLeftScore(score: m_iLeftScore);
        
        recordBoutEvent("Left scores");
    }
    
    /** 
    Score touch for fencer on the right 
    */
    public func touchRight() {
        m_iRightScore++;
        m_viewController.setRightScore(score: m_iRightScore);
        
        recordBoutEvent("Right scores");
    }
    
    /** 
    Score a double touch, if allowed by the bout type 
    */
    public func touchDouble() {
        m_iLeftScore++;
        m_iRightScore++;
        
        m_viewController.setLeftScore(score: m_iLeftScore);
        m_viewController.setRightScore(score: m_iRightScore);
        
        recordBoutEvent("Double-touch");
    }
    
    /** 
    Called on each tick of the timer.
    
    :fTimerValue: The value of the timer after the tick
    */
    func onTimerTick(fTimerValue:Float) {
        m_viewController.setCurrentTime(currentTime: fTimerValue);
    }
    
    /** Called by the timer when completed. */
    func onTimerFinish() {
        m_viewController.setCurrentTime(currentTime: 0);
    }
    
    /** 
    Record a message into the bout history
    
    :sMessage: The message to record. Timestamp and scores are automatically added.
    */
    private func recordBoutEvent(sMessage:String) {
        var time:Float? = m_timer?.currentTime;
        var event:BoutEvent = BoutEvent(time: time!, leftScore: m_iLeftScore, rightScore: m_iRightScore, sMessage: sMessage);
        m_boutEvents.append(event);
    }
}