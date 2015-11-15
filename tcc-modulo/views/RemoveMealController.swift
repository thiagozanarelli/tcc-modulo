//
//  RemoveMealController.swift
//  tcc-modulo
//
//  Created by thiago zanarelli on 11/12/15.
//  Copyright © 2015 TI IT ZanaLab. All rights reserved.
//

import Foundation

import UIKit

class RemoveMealController {
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    func show(meal:Meal, handler: (UIAlertAction!) -> Void){
        let details = UIAlertController(
            title: meal.name,
            message: meal.details(),
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let cancel = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )
        let remove = UIAlertAction(
            title: "Remove",
            style: UIAlertActionStyle.Destructive,
            handler: handler
        )
        details.addAction(cancel)
        details.addAction(remove)
        
        controller.presentViewController(details, animated: true, completion: nil)
    }
}
