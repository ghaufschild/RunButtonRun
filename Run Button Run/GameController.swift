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
    
    //////////////////////   Start of Main View     ///////////////////////
    
    var currentTime = 0.0               //Current time
    var gameStarted = false             //Used to start game
    var gameReady = true                //Used to help logic
    var checkHigh = true                //Whether to check for high score or not
    var segments: CGFloat = 7           //Number of segments
    var timer = NSTimer()               //Timer
    var time: Double = 0.0              //Time Variable
    
    var timeLabel: UILabel!         //Tells current time
    var bestTimeLabel: UILabel!     //Tells high score
    var walls: [UILabel] = []       //Walls
    
    var upArrow = UIButton(type: UIButtonType.System)           //move player up
    var downArrow = UIButton(type: UIButtonType.System)         //move player down
    var leftArrow = UIButton(type: UIButtonType.System)         //move player left
    var rightArrow = UIButton(type: UIButtonType.System)        //move player right
    var bestTimesList = UIButton(type: UIButtonType.System)     //allow user to reach high scores
    
    var gameHolder: UIView!                     //playing field
    
    var player: UIView!                         //user
    var enemy: UIView!                          //computer
    
    /////////////////////      Start of High Score View     /////////////
    
    var highScoreHolder: UIView!                //holds high scores
    
    var hsBestTime: UILabel!                    //Holds static "Best Times"
    var hsTime: UILabel!                        //Holds static "Time"
    
    var hsPlaces: UILabel!                      //Holds static "1.  2. 3. etc."
    var hsTimes: UILabel!                       //Holds top ten scores
    
    var doneButton: UIButton!                   //Reset the Game
    
    ///////////////////   Start of High Score Enter View   /////////////
    
    var highScoreEnter: UIView!                       //allows user to input score info
    
    
    var font20: CGFloat = 0.0       //fonts for similarity
    var font25: CGFloat = 0.0
    
    var wid: CGFloat!               //Used for reseting game - more info in view did load
    var barWid: CGFloat!            //Used for reseting game
    
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
        
        //Game Holder View
        gameHolder = UIView(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.15, screenWidth * 0.9, screenWidth * 0.9))
        gameHolder.backgroundColor = UIColor.whiteColor()
        view.addSubview(gameHolder)
        
        wid = gameHolder.frame.width * (segments - 1)/(segments * segments)           //Used for easy access
        
        //Bars
        for(var i: CGFloat = 0; i <= segments; i++)
        {
            let labelVer = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * i, 0, wid / (segments - 1), gameHolder.frame.height + wid / (segments - 1)))
            labelVer.backgroundColor = UIColor.blackColor()
            gameHolder.addSubview(labelVer)
            let labelHor = UILabel(frame: CGRectMake(0, gameHolder.frame.width/segments * i, gameHolder.frame.width, wid / (segments - 1)))
            labelHor.backgroundColor = UIColor.blackColor()
            gameHolder.addSubview(labelHor)
        }
        
        barWid = wid / (segments - 1)
        
        //User
        player = UIView(frame: CGRectMake(barWid, barWid, wid, wid))
        player.backgroundColor = UIColor.greenColor()
        gameHolder.addSubview(player)
        
        //Computer
        enemy = UIView(frame: CGRectMake(gameHolder.frame.width - wid, gameHolder.frame.width - wid, wid, wid))
        enemy.backgroundColor = UIColor.redColor()
        gameHolder.addSubview(enemy)
        
        //Walls
        let wall1 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments + barWid, gameHolder.frame.width/segments + barWid, wid, wid))
        wall1.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall1)
        let wall2 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 2 + barWid, gameHolder.frame.width/segments + barWid, wid, wid))
        wall2.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall2)
        let wall3 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 4 + barWid, gameHolder.frame.width/segments + barWid, wid, wid))
        wall3.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall3)
        let wall4 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 5 + barWid, gameHolder.frame.width/segments + barWid, wid, wid))
        wall4.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall4)
        let wall5 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments + barWid, gameHolder.frame.width/segments * 2 + barWid, wid, wid))
        wall5.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall5)
        let wall6 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 5 + barWid, gameHolder.frame.width/segments * 2 + barWid, wid, wid))
        wall6.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall6)
        let wall7 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 3 + barWid, gameHolder.frame.width/segments * 3 + barWid, wid, wid))
        wall7.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall7)
        let wall8 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments + barWid, gameHolder.frame.width/segments * 4 + barWid, wid, wid))
        wall8.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall8)
        let wall9 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 5 + barWid, gameHolder.frame.width/segments * 4 + barWid, wid, wid))
        wall9.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall9)
        let wall10 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments + barWid, gameHolder.frame.width/segments * 5 + barWid, wid, wid))
        wall10.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall10)
        let wall11 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 2 + barWid, gameHolder.frame.width/segments * 5 + barWid, wid, wid))
        wall11.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall11)
        let wall12 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 4 + barWid, gameHolder.frame.width/segments * 5 + barWid, wid, wid))
        wall12.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall12)
        let wall13 = UILabel(frame: CGRectMake(gameHolder.frame.width/segments * 5 + barWid, gameHolder.frame.width/segments * 5 + barWid, wid, wid))
        wall13.backgroundColor = UIColor.grayColor()
        gameHolder.addSubview(wall13)
        walls.append(wall1)
        walls.append(wall2)
        walls.append(wall3)
        walls.append(wall4)
        walls.append(wall5)
        walls.append(wall6)
        walls.append(wall7)
        walls.append(wall8)
        walls.append(wall9)
        walls.append(wall10)
        walls.append(wall11)
        walls.append(wall12)
        walls.append(wall13)
        
        //Distance to bottom of gameHolder
        let distFromGame = gameHolder.frame.maxY
        
        //Up Arrow Button
        upArrow = UIButton(frame: CGRectMake(screenWidth * 0.4, distFromGame + screenWidth * 0.1, screenWidth * 0.2, screenWidth * 0.2))
        upArrow.addTarget(self, action: "moveUp", forControlEvents: UIControlEvents.TouchUpInside)
        upArrow.setBackgroundImage(UIImage(named: "upArrow"), forState: .Normal)
        view.addSubview(upArrow)
        
        //Down Arrow Button
        downArrow = UIButton(frame: CGRectMake(screenWidth * 0.4, distFromGame + screenWidth * 0.35, screenWidth * 0.2, screenWidth * 0.2))
        downArrow.addTarget(self, action: "moveDown", forControlEvents: UIControlEvents.TouchUpInside)
        downArrow.setBackgroundImage(UIImage(named: "downArrow"), forState: .Normal)
        view.addSubview(downArrow)
        
        //Left Arrow Button
        leftArrow = UIButton(frame: CGRectMake(screenWidth * 0.15, distFromGame + screenWidth * 0.225, screenWidth * 0.2, screenWidth * 0.2))
        leftArrow.addTarget(self, action: "moveLeft", forControlEvents: UIControlEvents.TouchUpInside)
        leftArrow.setBackgroundImage(UIImage(named: "leftArrow"), forState: .Normal)
        view.addSubview(leftArrow)
        
        //Right Arrow Button
        rightArrow = UIButton(frame: CGRectMake(screenWidth * 0.65, distFromGame + screenWidth * 0.225, screenWidth * 0.2, screenWidth * 0.2))
        rightArrow.addTarget(self, action: "moveRight", forControlEvents: UIControlEvents.TouchUpInside)
        rightArrow.setBackgroundImage(UIImage(named: "rightArrow"), forState: .Normal)
        view.addSubview(rightArrow)
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        highScoreHolder = UIView(frame: CGRectMake(screenWidth * 0.15, screenHeight * 0.1, screenWidth * 0.7, screenHeight * 0.53))
        highScoreHolder.backgroundColor = UIColor.greenColor()
        highScoreHolder.layer.borderColor = UIColor.blackColor().CGColor
        highScoreHolder.layer.borderWidth = 5
        highScoreHolder.layer.cornerRadius = 25
        
        hsBestTime = UILabel(frame: CGRectMake(screenWidth * 0.05, screenHeight * 0.02, screenWidth * 0.6, screenHeight * 0.05))
        hsBestTime.textAlignment = .Center
        hsBestTime.text = "Best Times"
        hsBestTime.font = (UIFont(name: "default", size: font25))
        hsBestTime.adjustsFontSizeToFitWidth = true
        hsBestTime.textColor = UIColor.grayColor()
        highScoreHolder.addSubview(hsBestTime)
        
        hsPlaces = UILabel(frame: CGRectMake(0, screenHeight * 0.07, screenWidth * 0.2, screenHeight * 0.4))
        hsPlaces.textAlignment = .Right
        hsPlaces.text = "1. \n2. \n3. \n4. \n5. \n6. \n7. \n8. \n9. \n10. "
        hsPlaces.numberOfLines = 0
        hsPlaces.font = (UIFont(name: "default", size: font25))
        hsPlaces.adjustsFontSizeToFitWidth = true
        hsPlaces.textColor = UIColor.grayColor()
        highScoreHolder.addSubview(hsPlaces)
        
        hsTimes = UILabel(frame: CGRectMake(screenWidth * 0.4, screenHeight * 0.07, screenWidth * 0.3, screenHeight * 0.4))
        hsTimes.textAlignment = .Left
        hsTimes.text = "\(highScores[0]) \n\(highScores[1]) \n\(highScores[2]) \n\(highScores[3]) \n\(highScores[4]) \n\(highScores[5]) \n\(highScores[6]) \n\(highScores[7]) \n\(highScores[8]) \n1\(highScores[9]) "
        hsTimes.numberOfLines = 0
        hsTimes.font = (UIFont(name: "default", size: font25))
        hsTimes.adjustsFontSizeToFitWidth = true
        hsTimes.textColor = UIColor.grayColor()
        highScoreHolder.addSubview(hsTimes)
        
        doneButton = UIButton(frame: CGRectMake(screenWidth * 0.2, screenHeight * 0.45, screenWidth * 0.3, screenHeight * 0.05))
        doneButton.addTarget(self, action: "reset", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        highScoreHolder.addSubview(doneButton)
        
        //Main View
        view.backgroundColor = UIColor.greenColor()
    }
    
    //Direction Methods
    func moveUp()
    {
        startGame()                 //Checks to see if game has started
        move(0, yDirection: -1, name: "player")
        gameOver()                  //Check to see if game should be over
    }
    func moveDown()
    {
        startGame()
        move(0, yDirection: 1, name: "player")
        gameOver()
    }
    func moveLeft()
    {
        startGame()
        move(-1, yDirection: 0, name:  "player")
        gameOver()
    }
    func moveRight()
    {
        startGame()
        move(1, yDirection: 0, name: "player")
        gameOver()
    }
    
    func move(xDirection: CGFloat, yDirection: CGFloat, name: String)       //Used to move any object
    {
        if(gameStarted && gameReady)             //If game is still active
        {
            let unit: CGFloat = gameHolder.frame.width * 1/segments                //One square length
            if(name == "player")                    //Player is being moved
            {
                let newFrame = CGRectMake(player.frame.minX + (xDirection * unit), player.frame.minY + (yDirection * unit), player.frame.width, player.frame.width)
                if(validLoc(player.frame.minX + (xDirection * unit), xLocMax: player.frame.maxX + (xDirection * unit), yLocMin: player.frame.minY + (yDirection * unit), yLocMax: player.frame.maxY + (yDirection * unit), mover: newFrame))
                {
                    player.frame = newFrame
                }
            }
            if(name == "enemy")                     //Enemy is being moved
            {
                let newFrame = CGRectMake(enemy.frame.minX + (xDirection * unit), enemy.frame.minY + (yDirection * unit), enemy.frame.width, enemy.frame.width)
                if(validLoc(enemy.frame.minX + (xDirection * unit), xLocMax: enemy.frame.maxX + (xDirection * unit), yLocMin: enemy.frame.minY + (yDirection * unit), yLocMax: enemy.frame.maxY + (yDirection * unit), mover: newFrame))
                {
                    enemy.frame = newFrame
                }
            }
        }
    }
    
    func validLoc(xLocMin: CGFloat, xLocMax: CGFloat, yLocMin: CGFloat, yLocMax: CGFloat, mover: CGRect) -> Bool           //Check if location is valid
    {
        if(xLocMin >= 0 && xLocMax <= gameHolder.frame.width + 10
            && yLocMin >= 0 && yLocMax <= gameHolder.frame.width + 10)
        {
            for var i = 0; i < walls.count; i++
            {
                if(CGRectIntersectsRect(walls[i].frame, mover))
                {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func startGame()                //Run when the game starts
    {
        if(!gameStarted)
        {
            gameStarted = true
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timeUpdate"), userInfo: nil, repeats: true)
        }
    }
    
    func timeUpdate()               //Runs every 100th of a second
    {
        time = time + 0.1
        time = round(time * 10)/10
        timeLabel.text = "Time: \(time)"
        gameOver()
        
    }
    
    func gameOver()                 //Checks if game is over and ends the game properly
    {
        if(CGRectIntersectsRect(enemy.frame, player.frame))
        {
            gameReady = false
            gameStarted = false
            timer.invalidate()
            if(checkHigh)
            {
                checkHighScore()
                checkHigh = false
            }
            save()
            view.addSubview(highScoreHolder)
        }
    }
    
    func checkHighScore()           //Checks is current time is a high score
    {
        if time > highScores[highScores.count - 1]
        {
            var place = 0
            for(var i = 0; i < highScores.count; i++)
            {
                if(time > highScores[i])
                {
                    place = i
                    break
                }
            }
            highScores.insert(time, atIndex: place)
            highScores.popLast()
        }
        hsTimes.text = "\(highScores[0]) \n\(highScores[1]) \n\(highScores[2]) \n\(highScores[3]) \n\(highScores[4]) \n\(highScores[5]) \n\(highScores[6]) \n\(highScores[7]) \n\(highScores[8]) \n\(highScores[9])"
    }
    
    func reset()                    //Resets Game
    {
        time = 0.0
        timeLabel.text = "Time: \(time)"
        gameStarted = false
        gameReady = true
        checkHigh = true
        player.frame = CGRectMake(barWid, barWid, wid, wid)
        enemy.frame = CGRectMake(gameHolder.frame.width - wid, gameHolder.frame.width - wid, wid, wid)
        highScoreHolder.removeFromSuperview()
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

