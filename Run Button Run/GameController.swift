//
//  ViewController.swift
//  Run Button Run
//
//  Created by Garrett Haufschild on 12/18/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width           //Dimensions of phone
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var highScores = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]     //Array of high scores
    var currentTime = 0.0               //Current time
    var gameStarted = false             //Used to start game
    var segments: CGFloat = 8                    //Number of segments
    
    var timeLabel: UILabel!         //Tells current time
    var bestTimeLabel: UILabel!     //Tells high score
    var vertBars: [UILabel]!        //Holds Vertical Bars                   //******     MIGHT BE USELESS   ******
    var horBars: [UILabel]!         //Holds Horizontal Bars
    
    var upArrow = UIButton(type: UIButtonType.System)           //move player up
    var downArrow = UIButton(type: UIButtonType.System)         //move player down
    var leftArrow = UIButton(type: UIButtonType.System)         //move player left
    var rightArrow = UIButton(type: UIButtonType.System)        //move player right
    var bestTimesList = UIButton(type: UIButtonType.System)     //allow user to reach high scores
    
    var gameHolder: UIView!                     //playing field
    var gameBG: UIView!
    var highScoreHolder: UIView!                //holds high scores
    var gameDone: UIView!                       //allows user to input score info
    
    var player: UIView!                         //user
    var enemy: UIView!                          //computer
    
    var font20: CGFloat = 0.0       //fonts for similarity
    var font25: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        font20 = screenWidth * 0.053
        font25 = screenWidth * 0.067
        
        //Time Label
        timeLabel = UILabel(frame: CGRectMake(screenWidth * 0.03, screenHeight * 0.035, screenWidth * 0.35, screenHeight * 0.065))
        timeLabel.text = "Time: \(currentTime)"
        timeLabel.font = (UIFont(name: "default", size: font25))
        timeLabel.textAlignment = .Center
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.textColor = UIColor.grayColor()
        timeLabel.layer.backgroundColor = UIColor.whiteColor().CGColor
        timeLabel.layer.cornerRadius = screenWidth * 0.05
        view.addSubview(timeLabel)
        
        //Time Label
        bestTimeLabel = UILabel(frame: CGRectMake(screenWidth * 0.6, screenHeight * 0.035, screenWidth * 0.37, screenHeight * 0.065))
        bestTimeLabel.text = "Best Time: \(highScores[0])"
        bestTimeLabel.font = (UIFont(name: "default", size: font25))
        bestTimeLabel.textAlignment = .Center
        bestTimeLabel.adjustsFontSizeToFitWidth = true
        bestTimeLabel.textColor = UIColor.grayColor()
        bestTimeLabel.layer.backgroundColor = UIColor.whiteColor().CGColor
        bestTimeLabel.layer.cornerRadius = screenWidth * 0.05
        view.addSubview(bestTimeLabel)
        
        //Game Background - used for aesthetics
        gameBG = UIView(frame: CGRectMake(screenWidth * 0.03, screenHeight * 0.13, screenWidth * 0.94, screenWidth * 0.965))
        gameBG.backgroundColor = UIColor.whiteColor()
        view.addSubview(gameBG)
        
        //Game Holder View
        gameHolder = UIView(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.15, screenWidth * 0.9, screenWidth * 0.9))
        gameHolder.backgroundColor = UIColor.grayColor()
        view.addSubview(gameHolder)
        
        let wid = gameHolder.frame.width * (segments - 1)/(segments * segments)           //Used for easy access
        
        //User
        player = UIView(frame: CGRectMake(screenWidth * 0.05 + wid/7, screenHeight * 0.15 + wid/7, wid, wid))
        player.backgroundColor = UIColor.greenColor()
        view.addSubview(player)
        
        //Computer
        enemy = UIView(frame: CGRectMake(gameHolder.frame.maxX - wid, gameHolder.frame.maxY - wid, wid, wid))
        enemy.backgroundColor = UIColor.redColor()
        view.addSubview(enemy)
        
        //Up Arrow Button
        upArrow = UIButton(frame: CGRectMake(screenWidth * 0.4, screenWidth, screenWidth * 0.2, screenWidth * 0.2))
        upArrow.addTarget(self, action: "moveUp", forControlEvents: UIControlEvents.TouchUpInside)
        upArrow.backgroundColor = UIColor.blueColor()
        view.addSubview(upArrow)
        
        //Down Arrow Button
        downArrow = UIButton(frame: CGRectMake(screenWidth * 0.4, screenWidth * 1.4, screenWidth * 0.2, screenWidth * 0.2))
        downArrow.addTarget(self, action: "moveDown", forControlEvents: UIControlEvents.TouchUpInside)
        downArrow.backgroundColor = UIColor.blueColor()
        view.addSubview(downArrow)
        
        //Left Arrow Button
        leftArrow = UIButton(frame: CGRectMake(screenWidth * 0.2, screenWidth * 1.2, screenWidth * 0.2, screenWidth * 0.2))
        leftArrow.addTarget(self, action: "moveLeft", forControlEvents: UIControlEvents.TouchUpInside)
        leftArrow.backgroundColor = UIColor.blueColor()
        view.addSubview(leftArrow)
        
        //Right Arrow Button
        rightArrow = UIButton(frame: CGRectMake(screenWidth * 0.6, screenWidth * 1.2, screenWidth * 0.2, screenWidth * 0.2))
        rightArrow.addTarget(self, action: "moveRight", forControlEvents: UIControlEvents.TouchUpInside)
        rightArrow.backgroundColor = UIColor.blueColor()
        view.addSubview(rightArrow)
        
        //Bars
        for(var i: CGFloat = 0; i <= segments; i++)
        {
            let labelVer = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * i, 0, wid / (segments - 1), gameHolder.frame.height))
            labelVer.backgroundColor = UIColor.blackColor()
            gameHolder.addSubview(labelVer)
            let labelHor = UILabel(frame: CGRectMake(0, gameHolder.frame.width/segments * i, gameHolder.frame.width, wid / (segments - 1)))
            labelHor.backgroundColor = UIColor.blackColor()
            gameHolder.addSubview(labelHor)
        }
        
        //Main View
        view.backgroundColor = UIColor.blackColor()
    }
    
    //Direction Methods
    func moveUp()
    {
        move(0, yDirection: -1, name: "player")
    }
    func moveDown()
    {
        move(0, yDirection: 1, name: "player")
    }
    func moveLeft()
    {
        move(-1, yDirection: 0, name:  "player")
    }
    func moveRight()
    {
        move(1, yDirection: 0, name: "player")
    }
    
    func move(xDirection: CGFloat, yDirection: CGFloat, name: String)       //Used to move any object
    {
        let unit: CGFloat = gameHolder.frame.width * 1/segments                //One square length
        if(name == "player")                    //Player is being moved
        {
            print("Here")
            if(validLoc(player.frame.minX + (xDirection * unit), xLocMax: player.frame.maxX + (xDirection * unit), yLocMin: player.frame.minY + (yDirection * unit), yLocMax: player.frame.maxY + (yDirection * unit)))
            {
                print("got here")
                player.frame.offsetInPlace(dx: unit * xDirection, dy: unit * yDirection)
            }
        }
        if(name == "enemy")                     //Enemy is being moved
        {
            if(validLoc(enemy.frame.minX + (xDirection * unit), xLocMax: enemy.frame.maxX + (xDirection * unit), yLocMin: enemy.frame.minY + (yDirection * unit), yLocMax: enemy.frame.maxY + (yDirection * unit)))
            {
                enemy.frame.offsetInPlace(dx: unit * xDirection, dy: unit * yDirection)

            }
        }
    }
    
    func validLoc(xLocMin: CGFloat, xLocMax: CGFloat, yLocMin: CGFloat, yLocMax: CGFloat) -> Bool           //Check if location is valid
    {
        if(xLocMin >= gameHolder.frame.minX && xLocMax <= gameHolder.frame.maxX
            && yLocMin >= gameHolder.frame.minY && yLocMax <= gameHolder.frame.maxY)
        {
            return true
        }
        print(xLocMin, gameHolder.frame.minX, xLocMax, gameHolder.frame.maxX)
        print(yLocMin, gameHolder.frame.minY, yLocMax, gameHolder.frame.maxY)
            return false
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //High Score Stuff
    
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
        highScores[0] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore0")
        highScores[1] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore1")
        highScores[2] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore2")
        highScores[3] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore0")
        highScores[4] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore4")
        highScores[5] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore5")
        highScores[6] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore6")
        highScores[7] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore7")
        highScores[8] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore8")
        highScores[9] = NSUserDefaults.standardUserDefaults().doubleForKey("highScore9")
    }
    
    //      Clear
    //      NSUserDefaults.standardUserDefaults().removeObjectForKey("settings")

}

