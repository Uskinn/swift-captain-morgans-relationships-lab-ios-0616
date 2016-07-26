//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Sergey Nevzorov on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    
    let infoStore = DataStore.sharedDataStore

    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    var wholeDataFromShip: Ship?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shipNameLabel.text = wholeDataFromShip?.name
        self.pirateNameLabel.text = wholeDataFromShip?.pirate?.name
        self.propulsionTypeLabel.text = wholeDataFromShip?.engine?.gas
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
