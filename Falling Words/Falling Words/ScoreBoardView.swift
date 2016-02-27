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
    static var startScore = 1000
    var scoreStep = 100
    
    private var score: Int = ScoreBoardView.startScore
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
        self.score = ScoreBoardView.startScore
    }
    
    func incrementScore()
    {
        self.score += self.scoreStep
        self.happyScore()
    }
    
    private func happyScore()
    {
        // change color to red
        UIView.transitionWithView(self.scoreLabel!, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
            
            self.scoreLabel?.textColor = UIColor.greenColor()
            
            }) { (_) -> Void in }
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
            // make the score bigger
            self.scoreLabel?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.8, 1.8)
            
            }) { (_) -> Void in }
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseOut, animations: { () -> Void in
            // back the score to the normal size
            self.scoreLabel?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            
            }) { (_) -> Void in
                // change color back to black
                UIView.transitionWithView(self.scoreLabel!, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
                    
                    self.scoreLabel?.textColor = UIColor.blackColor()
                    
                    }) { (_) -> Void in }
        }
    }
    
    func decrementScore()
    {
        if self.score >= self.scoreStep
        {
            self.score -= self.scoreStep
            self.sadScore()
        }
    }
    
    private func sadScore()
    {
        UIView.transitionWithView(self.scoreLabel!, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
            self.scoreLabel?.textColor = UIColor.redColor()
            }) { (_) -> Void in }
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
            
            self.scoreLabel?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3)
            
            }) { (_) -> Void in }
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseOut, animations: { () -> Void in
            
            self.scoreLabel?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            
            }) { (_) -> Void in
                UIView.transitionWithView(self.scoreLabel!, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
                    
                    self.scoreLabel?.textColor = UIColor.blackColor()
                    
                    }) { (_) -> Void in }
        }
    }
}
