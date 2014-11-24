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
    var currentBattle:Int = 0
    
    var isVote = false
    
    //@IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet weak var char1Label: UILabel!
    @IBOutlet weak var char2Label: UILabel!
    
    @IBOutlet weak var char2Button: UIButton!
    @IBOutlet weak var char1Button: UIButton!
    
    @IBOutlet weak var p1Perct: UILabel!
    @IBOutlet weak var p2Perct: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateBattles()
    }
    
    
    func updateBattles(){
        battles = []
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
                    self.battles.append(Battle(objectId: object.objectId, char1: object["character_one"] as String,
                        char2: object["character_two"] as String,
                        voteChar1: object["vote_one"] as Float,
                        voteChar2: object["vote_two"] as Float))
                }
                self.char1Label.text = "\(self.battles[self.currentBattle].character1)"
                self.char2Label.text = "\(self.battles[self.currentBattle].character2)"
				
                var image = UIImage(named: (self.battles[self.currentBattle].character1 as NSString).lowercaseString)
				self.char1Button.setImage(image, forState: UIControlState.Normal)
				self.char1Button.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
				
                image = UIImage(named: (self.battles[self.currentBattle].character2 as NSString).lowercaseString)
				self.char2Button.setImage(image, forState: UIControlState.Normal)
				self.char2Button.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
				
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    
    @IBAction func char1Vote(sender: AnyObject) {
        if(!isVote){
            println("VOTE CHAR 1")
            battles[currentBattle].incChar1()
            p1Perct.text = "\(battles[currentBattle].getChar1Percentage()) %"
            p2Perct.text = "\(battles[currentBattle].getChar2Percentage()) %"
            isVote = true
        }
    }
	
	
    @IBAction func char2Vote(sender: AnyObject) {
        if(!isVote){
            println("VOTE CHAR 2")
            battles[currentBattle].incChar2()
            p1Perct.text = "\(battles[currentBattle].getChar1Percentage()) %"
            p2Perct.text = "\(battles[currentBattle].getChar2Percentage()) %"
            isVote = true
        }
    }

	@IBAction func nextBattle(sender: AnyObject) {
		currentBattle = (currentBattle + 1) % battles.count
		isVote = false
		p1Perct.text = ""
		p2Perct.text = ""
		
		char1Label.text = "\(battles[currentBattle].character1)"
		char2Label.text = "\(battles[currentBattle].character2)"
			
		var image = UIImage(named: (battles[currentBattle].character1 as NSString).lowercaseString)
		char1Button.setImage(image, forState: UIControlState.Normal)
		
		image = UIImage(named: (self.battles[currentBattle].character2 as NSString).lowercaseString)
		char2Button.setImage(image, forState: UIControlState.Normal)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

