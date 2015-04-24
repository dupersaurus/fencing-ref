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
    
    var m_viewController:ViewController;
    
    /** The score for the fencer on the left */
    var m_iLeftScore:UInt
    
    /** The score for the fencer on the right */
    var m_iRightScore:UInt
    
    /** The bout timer */
    var m_timer:Timer?;
    
    init(boutTime fTime:Float, viewController vc:ViewController) {
        m_viewController = vc;
        m_iLeftScore = 0;
        m_iRightScore = 0;
        
        m_timer = Timer(countdownFrom: fTime, withInterval: 0.1, tickCallback: onTimerTick, finishCallback: onTimerFinish);
    }
    
    /** Begin running the timer */
    public func start() {
        m_timer?.start();
    }
    
    /** Stop the timer */
    public func halt() {
        m_timer?.stop();
    }
    
    /** Score touch for fencer on the left */
    public func touchLeft() {
        
    }
    
    /** Score touch for fencer on the right */
    public func touchRight() {
        
    }
    
    /** Score a double touch, if allowed by the bout type */
    public func touchDouble() {
        
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
}