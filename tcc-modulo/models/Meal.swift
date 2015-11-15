//
//  Meal.swift
//  tcc-modulo
//
//  Created by thiago zanarelli on 11/10/15.
//  Copyright © 2015 TI IT ZanaLab. All rights reserved.
//

import Foundation

class Meal: NSObject, NSCoding{
    
    
    
    let name:String
    let happiness:Int
    var items = Array<Item>()
    init(name: String, happiness: Int) {
    self.name = name
    self.happiness = happiness
    }
    
    required init?(coder aDecoder: NSCoder){
        
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.happiness = aDecoder.decodeIntegerForKey("happiness")
        self.items = aDecoder.decodeObjectForKey("items") as! Array<Item>
        
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeInteger(self.happiness, forKey: "happiness")
        aCoder.encodeObject(self.items, forKey: "items")
    }
    
    func allCalories() -> Double {
        print("calculating")
        var total = 0.0
        for i in items {
        total += i.calories
        }
        return total
    }
    
    func details() -> String {
        var message = "Happiness: \(self.happiness)"
        for item in self.items {
        message
        += "\n * \(item.name) - calories: \(item.calories)"
        }
        return message
    }
    
    
    
}
