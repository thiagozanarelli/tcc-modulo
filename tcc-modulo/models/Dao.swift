//
//  Dao.swift
//  tcc-modulo
//
//  Created by thiago zanarelli on 11/12/15.
//  Copyright © 2015 TI IT ZanaLab. All rights reserved.
//

import Foundation


class Dao {
    let mealsArchive: String
    let itemsArchive: String
    
    init() {
        
        let userDir = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true
        )
        let dir = userDir[ 0 ] as String
        
        mealsArchive = "\(dir)/eggplant-brownie-meals"
        itemsArchive = "\(dir)/eggplant-brownie-items"
    }
    
    func saveMeals(meals: Array<Meal>){
        NSKeyedArchiver.archiveRootObject(meals, toFile: mealsArchive)
    }
    func saveItems(items: Array<Item>){
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsArchive)
    }
    func loadMeals() -> Array<Meal>{
        if let loaded: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(mealsArchive) {
        return loaded as! Array<Meal>
    }else{
        return Array<Meal>()
        }
    }
    func loadItems() -> Array<Item>{
        if let loaded: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithFile(itemsArchive) {
        return loaded as! Array<Item>
    }else{
        return Array<Item>()
        }
    }
    
}

