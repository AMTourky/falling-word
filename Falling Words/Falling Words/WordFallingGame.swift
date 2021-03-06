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
    static var roundLength = 4
    
    var gameView: UIView
    var controlView: ControlView
    var scoreboard: ScoreBoardView
    var fallingWordLabel: UILabel
    var targetTranslation: [String: String]
    {
        didSet
        {
            self.controlView.wordLabel?.text = self.targetTranslation["text_eng"]
        }
    }
    var targetTranslationIndex = 0
    var translationsBool: [[String: String]]
    var roundCounter = 0
    var visitedIndices = [Int]()
    var playerDidGiveCorrectAnswer = false
    
    
    var canContinueDropping: Bool
    {
        return !self.didWin && !self.didLose
    }
    
    var didWin: Bool
    {
        return self.scoreboard.reachedMaxScore
    }
    
    var didLose: Bool
    {
        return self.scoreboard.reachedZeroScore
    }
    
    var failingWordIsCorrect: Bool
    {
        return self.fallingWordLabel.text == self.targetTranslation["text_spa"]
    }
    
    init(gameView: UIView, andScoreboard scoreboard : ScoreBoardView, andControlView controlView: ControlView)
    {
        self.gameView = gameView
        self.controlView = controlView
        self.scoreboard = scoreboard
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
        self.playerDidGiveCorrectAnswer = false
        self.scoreboard.resetScore()
        self.roundCounter = 0
        self.targetTranslation = self.selectRandomTranslation(isFirstRound: true)
        self.dropAWord()
    }
    
    func selectRandomTranslation(isFirstRound firstRound: Bool = false) -> [String: String]
    {
        if !firstRound && !self.playerDidGiveCorrectAnswer
        {
            self.scoreboard.decrementScore()
        }
        self.playerDidGiveCorrectAnswer = false
        self.visitedIndices = [Int]()
        self.targetTranslationIndex = Int(arc4random_uniform( UInt32(self.translationsBool.count) ))
        return self.translationsBool[self.targetTranslationIndex]
    }
    
    func dropAWord()
    {
        self.controlView.enableInteraction()
        self.roundCounter++
        if self.roundCounter % WordFallingGame.roundLength == 0
        {
            self.targetTranslation = self.selectRandomTranslation()
        }
        self.fallingWordLabel.frame = WordFallingGame.initialFrameOfFallingWord
        self.fallingWordLabel.text = self.selectRandomForeign()
        UIView.animateWithDuration(3, delay: 0, options: .CurveLinear, animations: { () -> Void in
            
            self.fallingWordLabel.frame.origin.y = self.controlView.frame.minY - (self.fallingWordLabel.frame.height/2)
            }) { (_) -> Void in
                if self.canContinueDropping
                {
                    self.dropAWord()
                }
                else
                {
                    self.checkWinOrLose()
                }
        }
    }
    
    func selectRandomForeign() -> String?
    {
        let minimum = self.targetTranslationIndex-2
        var randomIndex = 0
        repeat
        {
            randomIndex = minimum + Int(arc4random_uniform( UInt32( 4 ) ))
        }
        while( randomIndex >= self.translationsBool.count || randomIndex < 0 || self.visitedIndices.indexOf(randomIndex) != nil)
        self.visitedIndices.append(randomIndex)
        return self.translationsBool[randomIndex]["text_spa"]
    }
    
    func playerSaidCorrect()
    {
        self.controlView.disableInteraction()
        if self.failingWordIsCorrect
        {
            self.scoreboard.incrementScore()
            self.playerDidGiveCorrectAnswer = true
            self.roundCounter = WordFallingGame.roundLength-1
        }
        else
        {
            self.scoreboard.decrementScore()
        }
        self.checkWinOrLose()
    }
    
    func playerSaidIncorrect()
    {
        self.controlView.disableInteraction()
        if !self.failingWordIsCorrect
        {
            self.scoreboard.incrementScore()
        }
        else
        {
            self.scoreboard.decrementScore()
        }
        self.checkWinOrLose()
    }
    
    private func checkWinOrLose()
    {
        if self.didWin
        {
            self.gameSuccess()
        }
        else if self.didLose
        {
            self.gameOver()
        }
    }
    
    private func gameSuccess()
    {
        print("YOU WIN :)")
        self.displayAlert(withTitle: "YOU WIN :)")
    }
    
    private func gameOver()
    {
        print("YOU LOSE! ;(")
        self.displayAlert(withTitle: "YOU LOSE! ;(")
    }
    
    func displayAlert(withTitle title: String)
    {
        let alertController = UIAlertController(title: title, message: "Looking fore a challenge?", preferredStyle: .Alert)
        
        let playAction = UIAlertAction(title: "New Game", style: .Default)
            { (action) in
                self.startNewGame()
        }
        alertController.addAction(playAction)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
