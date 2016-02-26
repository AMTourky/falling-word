//
//  ScoreBoardView.swift
//  Falling Words
//
//  Created by AMTourky on 2/26/16.
//  Copyright © 2016 AMTourky. All rights reserved.
//

import UIKit

class ScoreBoardView: UIView {

    var inceremntStep = 100
    var _score: Int = 0
    var score: Int
    {
        get
        {
            return self._score
        }
        set
        {
            self._score = newValue
            self.scoreLabel?.text = String(newValue)
        }
    }
    @IBOutlet var scoreLabel: UILabel?
    
    override func didMoveToSuperview()
    {
        
    }
    func resetScore()
    {
        self.score = 0
    }
    
    func incrementScore()
    {
        self.score += self.inceremntStep
    }
    
    func decrementScore()
    {
        if self.score >= self.inceremntStep
        {
            self.score -= self.inceremntStep
        }
    }
}
