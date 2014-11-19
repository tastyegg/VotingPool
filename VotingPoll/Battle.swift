//
//  Battle.swift
//  VotingPoll
//
//  Created by Jonathan Samudio on 11/18/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class Battle {
    init(char1:String, char2:String, voteChar1:Int, voteChar2:Int) {
        self.character1 = char1
        self.character2 = char2
        self.voteChar1 = voteChar1
        self.voteChar2 = voteChar2
    }
    
    var character1:String
    var character2:String
    
    var voteChar1:Int
    var voteChar2:Int
    
    func getChar1Percentage()->Int{
        return (voteChar1/(voteChar1+voteChar2) ) * 100
    }
    func getChar2Percentage()->Int{
        return (voteChar2/(voteChar1+voteChar2) ) * 100
    }
    
}