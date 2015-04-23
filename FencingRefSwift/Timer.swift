//
//  Timer.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/19/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation

/** Manages a looping timer */
public class Timer {
    
    /** The current time, in seconds */
    var m_fTime:Float;
    
    /** Whether the timer is ticking up (true) or down (false) */
    var m_bTickUp:Bool;
    
    /** The rate, in seconds, the timer ticks at */
    var m_fTickInterval:NSTimeInterval;
    
    var m_timer:NSTimer?;
    
    /** The current value of the timer */
    var currentTime:Float {
        return m_fTime;
    }
    
    /** 
    Init a timer that ticks up with an 0.1 second interval. 
    */
    init() {
        m_fTime = 0;
        m_bTickUp = true;
        m_fTickInterval = 0.1;
    }
    
    /** 
    Init a timer that counts down from a specific time 
    
    :param: fTime The time to start at
    
    :param: fInterval The rate, in seconds, the counter ticks at.
    */
    init(countdownFrom fTime:Float, fInterval:Double) {
        m_fTime = fTime;
        m_bTickUp = false;
        m_fTickInterval = NSTimeInterval(fInterval);
    }
    
    /** 
    Init a timer that counts up with a specific interval 
    
    :param: fInterval The rate, in seconds, the counter ticks at.
    */
    init(fInterval:Float) {
        m_fTime = 0;
        m_bTickUp = true;
        m_fTickInterval = NSTimeInterval(fInterval);
    }
    
    /** Start running the timer */
    public func start() {
        if m_timer != nil {
            return;
        }
        
        m_timer = NSTimer(timeInterval: m_fTickInterval, target: self, selector: Selector("timerTick"), userInfo: nil, repeats: true);
    }
    
    /** Stop the timer */
    public func stop() {
        m_timer?.invalidate();
    }
    
    func timerTick() {
        if (m_bTickUp) {
            m_fTime += m_fTickInterval;
        } else {
            m_fTime -= m_fTickInterval;
            
            if m_fTime <= 0 {
                m_fTime = 0;
                stop();
                
                // TODO callback
            }
        }
    }
}