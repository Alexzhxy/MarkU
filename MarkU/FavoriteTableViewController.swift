//
//  FavoritesTableViewController.swift
//  MarkU
//
//  Created by Zhang, Alex on 10/15/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class FavoriteTableViewController: UITableViewController {

    var destinationCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add customized table cell
        let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSavedFavoriteItems()
    }
    
    // load Core Data to memory
    private func loadSavedFavoriteItems(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "FavoriteItem")
        
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
        return g_favoriteItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell: FavoriteTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("FavoriteTableViewCell") as! FavoriteTableViewCell
        
        let favoriteItem = g_favoriteItems[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        let dateString = dateFormatter.stringFromDate((favoriteItem.valueForKey("date") as? NSDate)!)
        
        cell.position.text = favoriteItem.valueForKey("position") as? String
        cell.timeStamp.text = dateString
        
        return cell
    }
    
    // swipe to delete
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
    
    // select table cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        destinationCoordinate = CLLocationCoordinate2DMake(g_favoriteItems[indexPath.row].valueForKey("latitude") as! Double, g_favoriteItems[indexPath.row].valueForKey("longitude") as! Double)
        self.performSegueWithIdentifier("FavoriteToNavigationSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FavoriteToNavigationSegue" {
            let navigationVC: NavigationViewController = segue.destinationViewController as! NavigationViewController
            navigationVC.destinationCoordinate = destinationCoordinate
        }
           
    }

}
