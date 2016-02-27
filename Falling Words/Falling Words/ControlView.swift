//
//  ControlView.swift
//  Falling Words
//
//  Created by AMTourky on 2/26/16.
//  Copyright © 2016 AMTourky. All rights reserved.
//

import UIKit

class ControlView: UIView {
    
    @IBOutlet var wordLabel: UILabel?
    @IBOutlet var correctButton: UIButton?
    @IBOutlet var incorrectButton: UIButton?
    
    func enableInteraction()
    {
        self.correctButton?.enabled = true
        self.incorrectButton?.enabled = true
    }
    
    func disableInteraction()
    {
        self.correctButton?.enabled = false
        self.incorrectButton?.enabled = false
    }
}
