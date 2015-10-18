//
//  FavoritesTableViewController.swift
//  MarkU
//
//  Created by Zhang, Alex on 10/15/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "FavoriteItem")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            g_favoriteItems = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return g_favoriteItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell: FavoriteTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("FavoriteTableViewCell") as! FavoriteTableViewCell
        
        let favoriteItem = g_favoriteItems[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        let dateString = dateFormatter.stringFromDate((favoriteItem.valueForKey("date") as? NSDate)!)
        
        cell.position.text = favoriteItem.valueForKey("position") as! String
        cell.timeStamp.text = dateString
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        managedContext.deleteObject(g_favoriteItems[indexPath.row])
        g_favoriteItems.removeAtIndex(indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let vc: UIViewController = storyboard!.instantiateViewControllerWithIdentifier("Test") as UIViewController
        //self.presentViewController(vc, animated: false, completion: nil)
        //self.performSegueWithIdentifier("FavoritesTableItemSegue", sender: self)
    }

}
