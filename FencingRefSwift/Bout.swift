//
//  Bout.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 4/19/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation

/** The main manager of a bout. */
class Bout {
    
    /** The score for the fencer on the left */
    var m_iLeftScore:UInt
    
    /** The score for the fencer on the right */
    var m_iRightScore:UInt
    
    /** The bout timer */
    var m_timer:Timer;
    
    init(boutTime fTime:Float) {
        m_iLeftScore = 0;
        m_iRightScore = 0;
        m_timer = Timer(countdownFrom: fTime, fInterval: 0.1);
    }
}