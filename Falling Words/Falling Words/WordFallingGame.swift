//
//  WordFallingGame.swift
//  Falling Words
//
//  Created by AMTourky on 2/26/16.
//  Copyright © 2016 AMTourky. All rights reserved.
//

import UIKit

class WordFallingGame: NSObject {
    
    static var screenBounds = UIScreen.mainScreen().bounds
    
    static var initialFrameOfFallingWord: CGRect
    {
        return CGRect(x: 0, y: 0, width: WordFallingGame.screenBounds.width, height: 50)
    }
    
    var gameView: UIView
    var controlView: ControlView
    var fallingWordLabel: UILabel
    var targetTranslation: [String: String]
    var targetTranslationIndex = 0
    var translationsBool: [[String: String]]
    
    var canContinueDropping: Bool
    {
        return !self.didWin
    }
    
    var didWin: Bool
    {
        return false
    }
    
    var failingWordIsCorrect: Bool
    {
        return self.fallingWordLabel.text == self.targetTranslation["text_spa"]
    }
    
    init(gameView: UIView, andControlView controlView: ControlView)
    {
        self.gameView = gameView
        self.controlView = controlView
        self.fallingWordLabel = UILabel(frame: WordFallingGame.initialFrameOfFallingWord)
        self.fallingWordLabel.textAlignment = .Center
        self.gameView.addSubview(self.fallingWordLabel)
        self.targetTranslation = [String: String]()
        self.translationsBool = [[String: String]]()
        super.init()
        if let theTranslations = self.loadTranslationsFromJSON()
        {
            self.translationsBool = theTranslations
        }
        else
        {
            NSLog("Failed to load translations")
        }
    }
    
    func loadTranslationsFromJSON() -> [[String: String]]?
    {
        if let path = NSBundle.mainBundle().pathForResource("words", ofType: "json")
        {
            if let jsonData = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            {
                let jsonResult = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [[String: String]]
                if let theJsonResult = jsonResult
                {
                    return theJsonResult
                }
            }
        }
        return nil
        
    }
    
    func startNewGame()
    {
        self.targetTranslation = self.selectRandomTranslation()
        self.controlView.wordLabel?.text = self.targetTranslation["text_eng"]
        self.dropAWord()
    }
    
    func selectRandomTranslation() -> [String: String]
    {
        self.targetTranslationIndex = Int(arc4random_uniform( UInt32(self.translationsBool.count) ))
        return self.translationsBool[self.targetTranslationIndex]
    }
    
    func dropAWord()
    {
        self.fallingWordLabel.frame = WordFallingGame.initialFrameOfFallingWord
        self.fallingWordLabel.text = self.selectRandomForeign()
        UIView.animateWithDuration(2, delay: 0, options: .CurveLinear, animations: { () -> Void in
            
            self.fallingWordLabel.frame.origin.y = self.controlView.frame.minY - (self.fallingWordLabel.frame.height/2)
            }) { (_) -> Void in
                if self.canContinueDropping
                {
                    self.dropAWord()
                }
        }
    }
    
    func selectRandomForeign() -> String?
    {
        let randomIndex = Int(arc4random_uniform( UInt32(self.translationsBool.count) ))
        return self.translationsBool[randomIndex]["text_spa"]
    }
    
    func playerSaidCorrect()
    {
        if self.failingWordIsCorrect
        {
            print("Great")
        }
        else
        {
            print("It's the wrong word!")
        }
    }
    
    func playerSaidIncorrect()
    {
        if !self.failingWordIsCorrect
        {
            print("You are right, it was wrong")
        }
        else
        {
            print("ops, it was it!")
        }
    }
}
