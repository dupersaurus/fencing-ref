//
//  Bout15Touch.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 5/10/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation

public class Bout15Touch : Bout {
    
    override func setupBout() {
        super.setupBout();
        
        m_iPeriod = 1;
        m_viewController.setPeriodLabel(labelText: "Period 1");
    }
    
    override public func periodBreakComplete() {
        m_iPeriod++;
        
        if m_iPeriod <= 3 {
            m_viewController.setPeriodLabel(labelText: "Period \(m_iPeriod)");
        } else if leftScore == rightScore {
            m_viewController.wantPriority(true);
        }
    }
    
    /** Called at the end of the period. Handle switching to the next. */
    override func endOfPeriod() {
        
    }
    
    /** Called whenever the score is changed */
    override func scoreUpdated() {
        if leftScore >= 15 || rightScore >= 15 {
            m_viewController.alert();
        }
    }
}