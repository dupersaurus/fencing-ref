//
//  Timer.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/19/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation

/** Manages a looping timer */
public class Timer : NSObject {
    
    /** The current time, in seconds */
    var m_fTime:Float;
    
    /** The current value of the timer */
    var currentTime:Float {
        return m_fTime;
    }
    
    /** Whether the timer is ticking up (true) or down (false) */
    var m_bTickUp:Bool;
    
    /** The rate, in seconds, the timer ticks at */
    var m_fTickInterval:NSTimeInterval;
    
    var m_timer:NSTimer?;
    
    /** Called on each tick of the timer */
    var m_cbTick:((Float)->Void)?;
    
    /** If counting down, function to call on zero */
    var m_cbFinish:(Void->Void)?;
    
    /** 
    Init a timer that ticks up with an 0.1 second interval. 
    */
    override init() {
        m_fTime = 0;
        m_bTickUp = true;
        m_fTickInterval = 0.1;
    }
    
    /** 
    Init a timer that counts down from a specific time 
    
    :param: countdownFrom The time to start at
    
    :param: withInterval The rate, in seconds, the counter ticks at.
    
    :param: tickCallback A function to call on each tick of the timer
    
    :param: finishCallback A function with no parameters called when the timer reaches zero.
    */
    init(countdownFrom fTime:Float, withInterval fInterval:Double, tickCallback cbTick: (Float)->Void, finishCallback cbFinish: (Void)->Void) {
        m_fTime = fTime;
        m_bTickUp = false;
        m_fTickInterval = NSTimeInterval(fInterval);
        m_cbFinish = cbFinish;
        m_cbTick = cbTick;
    }
    
    /** 
    Init a timer that counts up with a specific interval 
    
    :param: fInterval The rate, in seconds, the counter ticks at.
    
    :param: tickCallback A function to call on each tick of the timer
    */
    init(fInterval:Float, tickCallback cbTick: (NSTimeInterval)->Void) {
        m_fTime = 0;
        m_bTickUp = true;
        m_fTickInterval = NSTimeInterval(fInterval);
    }
    
    /** Start running the timer */
    public func start() {
        if m_timer != nil {
            return;
        }
        
        m_timer = NSTimer.scheduledTimerWithTimeInterval(m_fTickInterval, target: self, selector: Selector("timerTick:"), userInfo: nil, repeats: true);
    }
    
    /** Stop the timer */
    public func stop() {
        m_timer?.invalidate();
    }
    
    func timerTick(timer:NSTimer) {
        if (m_bTickUp) {
            m_fTime += Float(m_fTickInterval);
            m_cbTick?(m_fTime);
        } else {
            m_fTime -= Float(m_fTickInterval);
            m_cbTick?(m_fTime);
            
            if m_fTime <= 0 {
                m_fTime = 0;
                stop();
                m_cbFinish?();
            }
        }
    }
}