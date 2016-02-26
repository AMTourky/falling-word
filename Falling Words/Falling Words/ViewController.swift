//
//  ViewController.swift
//  Falling Words
//
//  Created by AMTourky on 2/26/16.
//  Copyright © 2016 AMTourky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: WordFallingGame?
    @IBOutlet var controlView: ControlView?
    @IBOutlet var scoreboard: ScoreBoardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theView = self.view, theControlView = self.controlView, theScoreboard = self.scoreboard
        {
            self.game = WordFallingGame(gameView: theView, andScoreboard: theScoreboard, andControlView: theControlView)
            self.game?.startNewGame()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func correctTapped(sender: AnyObject)
    {
        self.game?.playerSaidCorrect()
    }
    
    @IBAction func incorrectTapped(sender: AnyObject)
    {
        self.game?.playerSaidIncorrect()
    }

}

