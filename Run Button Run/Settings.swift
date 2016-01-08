//
//  Settings.swift
//  Run Button Run
//
//  Created by Garrett Haufschild on 1/8/16.
//  Copyright © 2016 Swag Productions. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    var
    
    
    //NSCoding Stuff
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        self.customButtons = aDecoder.decodeObjectForKey("customButtons") as! Array<Bool>
        self.customBackgrounds = aDecoder.decodeObjectForKey("customBackgrounds") as! Array<Bool>
        self.highScores = aDecoder.decodeObjectForKey("highScores") as! Array<Double>
        self.currency = aDecoder.decodeIntegerForKey("currency")
        self.font = aDecoder.decodeObjectForKey("font") as! String
        self.buttonColor = aDecoder.decodeIntegerForKey("buttonColor")
        self.backgroundColor = aDecoder.decodeIntegerForKey("backgroundColor")
        self.difficulty = aDecoder.decodeIntegerForKey("difficulty")
        self.textColor = aDecoder.decodeObjectForKey("textColor") as! UIColor
        self.textBackground = aDecoder.decodeObjectForKey("textBackground") as! UIColor
    }
    
    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.customButtons, forKey: "customButtons")
        coder.encodeObject(self.customBackgrounds, forKey: "customBackgrounds")
        coder.encodeObject(self.highScores, forKey: "highScores")
        coder.encodeInteger(self.currency, forKey: "currency")
        coder.encodeObject(self.font, forKey: "font")
        coder.encodeInteger(self.buttonColor, forKey: "buttonColor")
        coder.encodeInteger(self.backgroundColor, forKey: "backgroundColor")
        coder.encodeInteger(self.difficulty, forKey: "difficulty")
        coder.encodeObject(self.textColor, forKey: "textColor")
        coder.encodeObject(self.textBackground, forKey: "textBackground")
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "settings")
    }
    
    class func loadSaved() -> Settings? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("settings") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Settings
        }
        return nil
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("settings")
    }
}
