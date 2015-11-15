//
//  ViewController.swift
//  tcc-modulo
//
//  Created by thiago zanarelli on 11/10/15.
//  Copyright © 2015 TI IT ZanaLab. All rights reserved.
//

import UIKit
import GoogleMobileAds


protocol AddAMealDelegate {
    func add(meal: Meal)
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {
    
    @IBOutlet weak var bannerView: DFPBannerView!
   
    var interstitial: GADInterstitial?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
   
    var items = Array<Item>()
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var happinessField: UITextField!
    @IBOutlet var tableView: UITableView?
    
    var delegate:AddAMealDelegate?
    var selected = Array<Item>()
    
    func getUserDir() -> String {
        let userDir = NSSearchPathForDirectoriesInDomains(
        NSSearchPathDirectory.DocumentDirectory,
        NSSearchPathDomainMask.UserDomainMask,
        true)
        return userDir[ 0 ] as String
    }
    
    override func viewDidLoad() {
        bannerView.adUnitID = "/6499/example/banner"
        bannerView.rootViewController = self
        bannerView.loadRequest(DFPRequest())
        interstitial = DFPInterstitial(adUnitID: "/6499/example/interstitial")
        print("Banner-------")
        interstitial!.loadRequest(DFPRequest())
        
        let newItemButton = UIBarButtonItem(title: "new item",
        style: UIBarButtonItemStyle.Plain,
        target: self,
        action: Selector("showNewItem"))
        navigationItem.rightBarButtonItem = newItemButton
        
       items = Dao().loadItems()
        
            
        
        
    }

    
    func addNew(item: Item) {
        if (interstitial!.isReady){
            interstitial!.presentFromRootViewController(self)
        }
        items.append(item)
            Dao().saveItems(items)
            
            if let table = tableView {
            table.reloadData()
        } else {
            Alert(controller: self).show("Unexpected error, but the item was added.")
            }
    }

    func tableView(tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
            return items.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
                let row = indexPath.row
                let item = items[ row ]
                let cell = UITableViewCell(style:
        UITableViewCellStyle.Default,reuseIdentifier: nil)
                cell.textLabel!.text = item.name
                return cell
    }
    
    func tableView(tableView: UITableView,
            didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if cell == nil {
            return }
            if (cell!.accessoryType ==
            UITableViewCellAccessoryType.None) {
            cell!.accessoryType =
            UITableViewCellAccessoryType.Checkmark
            selected.append(items[indexPath.row])
        } else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
            if let position = find(selected, toFind: items[indexPath.row]) {
            selected.removeAtIndex(position)
            }
            }
    }
    
   
    
    @IBAction func showNewItem() {
        
            let newItem = NewItemViewController(delegate: self)
            if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
            }else {
                Alert(controller: self).show()
                }
    }
    
    @IBAction func add(){
        if let meal = getMealFromForm() {
                if let meals = delegate {
                meals.add(meal)
                if let navigation = self.navigationController {
                navigation.popViewControllerAnimated(true)
            } else {
                Alert(controller: self).show(
                "Unexpected error, but the meal was added.")
                }
                return }
                }
                Alert(controller: self).show()
    }
    
    func getMealFromForm() -> Meal? {
        if nameField == nil || happinessField == nil {
        return nil }
        let name = nameField!.text
        let happiness = Int(happinessField!.text!)
        if happiness == nil {
        return nil }
        let meal = Meal(name: name!, happiness: happiness!)
        meal.items = selected
        print(
        "eaten: \(meal.name) \(meal.happiness) \(meal.items)")
        return meal
    }
    
    func find(elements:Array<Item>, toFind:Item) -> Int? {
        let max = elements.count - 1
        for i in 0...max {
        if toFind == elements[i] {
        return i
        } }
        return nil }
}

