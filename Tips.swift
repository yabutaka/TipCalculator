//
//  Tips.swift
//  tippy
//
//  Created by 薮田隆司 on 09/11/2018.
//  Copyright © 2018 Takashi.Co. All rights reserved.
//

import UIKit

class Tips{
    
    //MARK: Properties
    
    var tipPercentages = [0.15, 0.2, 0.25]
    
    //MARK: Initialization
    
    init(newTipPercentages: [Double]) {
        
        //Initialize the stored properties
        self.tipPercentages = newTipPercentages
    }
}
