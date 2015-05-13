//
//  Bout15Touch.swift
//  FencingRefSwift
//
//  Created by Jason DuPertuis on 5/10/15.
//  Copyright (c) 2015 jdp. All rights reserved.
//

import Foundation

public class BoutFIETeam : Bout {
    
    override func setupBout() {
        super.setupBout();
        
        maxPeriods = 9;
        pointTarget = 5;
    }
    
    override func resetToDefault() {
        super.resetToDefault();
        
        pointTarget = 5;
        m_viewController.setPeriodLabel(labelText: "Period 1");
        m_viewController.setFencingToScore(score: pointTarget);
    }
    
    override public func periodBreakComplete() {
        currentPeriod++;
        pointTarget = 5 * currentPeriod;
        m_viewController.setFencingToScore(score: pointTarget);
        
        if currentPeriod <= maxPeriods {
            m_viewController.setPeriodLabel(labelText: "Period \(currentPeriod)");
        } else if leftScore == rightScore {
            m_viewController.wantPriority(true);
        }
        
        super.periodBreakComplete();
    }
}