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
    var controlView: UIView
    
    init(gameView: UIView, andControlView controlView: UIView)
    {
        self.gameView = gameView
        self.controlView = controlView
    }
    
}
