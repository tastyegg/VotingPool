//
//  Battle.swift
//  VotingPoll
//
//  Created by Jonathan Samudio on 11/18/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class Battle {
    init(objectId:String, char1:String, char2:String, voteChar1:Float, voteChar2:Float) {
        self.character1 = char1
        self.character2 = char2
        self.voteChar1 = voteChar1
        self.voteChar2 = voteChar2
        self.objId = objectId
    }
    
    var objId:String
    
    var character1:String
    var character2:String
    
    var voteChar1:Float
    var voteChar2:Float
    
    func getChar1Percentage()->Float{
        var g:Float = (voteChar1/(voteChar1+voteChar2) ) * 100
        println(g)
        return ceilf( voteChar1/(voteChar1+voteChar2)  * 100)
    }
    func getChar2Percentage()->Float{
        return ceilf( voteChar2/(voteChar1+voteChar2)  * 100)
    }
    
    func incChar1(){
        self.voteChar1++
        var query = PFQuery(className:"Battle")
        query.getObjectInBackgroundWithId(objId) {
            (gameScore: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                gameScore["vote_one"] = self.voteChar1
                gameScore.saveEventually()
            }
        }
    }
    
    func incChar2(){
        self.voteChar2++
        var query = PFQuery(className:"Battle")
        query.getObjectInBackgroundWithId(objId) {
            (gameScore: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                gameScore["vote_two"] = self.voteChar2
                gameScore.saveEventually()
            }
        }
    }
    
}