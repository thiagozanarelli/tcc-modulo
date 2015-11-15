//
//  Alert.swift
//  tcc-modulo
//
//  Created by thiago zanarelli on 11/12/15.
//  Copyright © 2015 TI IT ZanaLab. All rights reserved.
//

import UIKit

class Alert {
    
    let controller: UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func show(message:String = "Unexpected error. ") {
        let details = UIAlertController(title: "Sorry",
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "Understood",
        style: UIAlertActionStyle.Cancel, handler: nil)
        
        details.addAction(cancel)
        controller.presentViewController(details,
        animated: true, completion: nil)
    }
}