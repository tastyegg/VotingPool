//
//  ViewController.swift
//  VotingPoll
//
//  Created by Jonathan Samudio on 11/18/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var battles:[Battle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var query = PFQuery(className:"Battle")
        //query.whereKey("character_one", equalTo:"Superman")
        query.findObjects()
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                    var t:String = object["character_one"] as String
                    println(t)
                    self.battles.append(Battle(char1: object["character_one"] as String,
                                         char2: object["character_one"] as String,
                                         voteChar1: object["vote_one"] as Int,
                                         voteChar2: object["vote_two"] as Int))
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

