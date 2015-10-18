//
//  SaveViewController.swift
//  MarkU
//
//  Created by Zhang, Alex on 10/17/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit
import CoreData

class SaveViewController: UITableViewController {
    
    
    @IBOutlet weak var PositionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePosition" {

            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let entity =  NSEntityDescription.entityForName("FavoriteItem",
                inManagedObjectContext:managedContext)
            
            let favoriteItem = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext: managedContext)
            
            favoriteItem.setValue(NSDate(), forKey: "date")
            favoriteItem.setValue(PositionTextField.text, forKey: "position")
            favoriteItem.setValue(g_locationCoordinate?.coordinate.latitude, forKey: "latitude")
            favoriteItem.setValue(g_locationCoordinate?.coordinate.longitude, forKey: "longitude")
            
            
            do {
                try managedContext.save()
                g_favoriteItems.append(favoriteItem)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }

}
