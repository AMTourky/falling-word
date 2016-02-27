//
//  ScoreBoardView.swift
//  Falling Words
//
//  Created by AMTourky on 2/26/16.
//  Copyright © 2016 AMTourky. All rights reserved.
//

import UIKit

class ScoreBoardView: UIView {

    static var maxScore = 2000
    var scoreStep = 100
    
    private var score: Int = 1000
    {
        didSet
        {
            self.scoreLabel?.text = String(self.score)
        }
    }
    @IBOutlet var scoreLabel: UILabel?
    
    var reachedMaxScore: Bool
    {
        return self.score == ScoreBoardView.maxScore
    }
    
    var reachedZeroScore: Bool
    {
        return self.score <= 0
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
