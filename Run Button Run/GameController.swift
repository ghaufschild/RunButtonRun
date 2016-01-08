//
//  ViewController.swift
//  Run Button Run
//
//  Created by Garrett Haufschild on 12/18/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var highScores = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    func save()
    {
        NSUserDefaults.standardUserDefaults().setDouble(highScores[0], forKey: "highScore0")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[1], forKey: "highScore1")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[2], forKey: "highScore2")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[3], forKey: "highScore3")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[4], forKey: "highScore4")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[5], forKey: "highScore5")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[6], forKey: "highScore6")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[7], forKey: "highScore7")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[8], forKey: "highScore8")
        NSUserDefaults.standardUserDefaults().setDouble(highScores[9], forKey: "highScore9")
    }
    
    func load()
    {
        //highScores = NSUserDefaults.standardUserDefaults().objectForKey("highScore")
    }
}

