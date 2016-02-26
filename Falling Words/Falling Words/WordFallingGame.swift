//
//  WordFallingGame.swift
//  Falling Words
//
//  Created by AMTourky on 2/26/16.
//  Copyright © 2016 AMTourky. All rights reserved.
//

import UIKit

class WordFallingGame: NSObject {
    var gameView: UIView
    var controlView: ControlView
    var fallingWordLabel: UILabel
    var targetTranslation: [String: String]
    
    
    init(gameView: UIView, andControlView controlView: ControlView)
    {
        self.gameView = gameView
        self.controlView = controlView
        self.fallingWordLabel = UILabel(frame: CGRect(x: 200, y: 50, width: 300, height: 50))
        self.fallingWordLabel.text = "A Falling Word!"
        self.gameView.addSubview(self.fallingWordLabel)
        self.targetTranslation = [String: String]()
    }
    
    func startNewGame()
    {
        self.targetTranslation = self.selectRandomTranslation()
        self.dropAWord()
    }
    
    func selectRandomTranslation() -> [String: String]
    {
        return ["original": "Hello", "translation": "Hallo"]
    }
    
    func dropAWord()
    {
        self.fallingWordLabel.text = self.selectRandomForeign()
        UIView.animateWithDuration(3, animations: { () -> Void in
            self.fallingWordLabel.center.y = self.controlView.center.y+self.fallingWordLabel.frame.height
            }) { (_) -> Void in
                
        }
    }
    
    func selectRandomForeign() -> String
    {
        return "Holla"
    }
}
