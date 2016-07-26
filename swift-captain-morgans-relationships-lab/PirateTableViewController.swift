//
//  PirateTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Sergey Nevzorov on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PirateTableViewController: UITableViewController {
    
    let infoStore = DataStore.sharedDataStore
 
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        infoStore.fetchData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        infoStore.fetchData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoStore.pirates.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("pirateCell", forIndexPath: indexPath)
        let eachPirate = infoStore.pirates[indexPath.row]
        cell.textLabel?.text = eachPirate.name
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        
        if segue.identifier == "shipsSegue" {
            
            let destinationVC = segue.destinationViewController as! ShipTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            let eachShip = self.infoStore.pirates[(indexPath?.row)!].ships
           // print("each ship: \(indexPath?.row)")

            
            if let eachShip = eachShip {
                destinationVC.pirateShip = eachShip
            }
        }
    }
}
