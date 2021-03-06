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
        
        maxPeriods = 3;
        pointTarget = 15;
    }
    
    override func resetToDefault() {
        super.resetToDefault();
        
        m_viewController.setPeriodLabel(labelText: "Period 1");
        m_viewController.setFencingToScore(score: pointTarget);
    }
    
    override public func periodBreakComplete() {
        currentPeriod += 1;
        
        if currentPeriod <= 3 {
            m_viewController.setPeriodLabel(labelText: "Period \(currentPeriod)");
        } else if leftScore == rightScore {
            m_viewController.wantPriority(true);
        }
        
        super.periodBreakComplete();
    }
}