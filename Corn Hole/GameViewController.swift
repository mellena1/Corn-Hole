//
//  GameViewController.swift
//  Corn Hole
//
//  Created by Andrew Mellen on 1/8/17.
//  Copyright © 2017 Andrew Mellen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    //Team 1
    var tOneNames:[String]!
    var tOneName:String!
    var tOneNumPlayers:Int!
    var tOneScores:[Int] = []
    
    //Team 2
    var tTwoNames:[String]!
    var tTwoName:String!
    var tTwoNumPlayers:Int!
    var tTwoScores:[Int] = []
    
    //GUI Stuff
    @IBOutlet weak var tOneLabel: UILabel!
    @IBOutlet weak var tTwoLabel: UILabel!
    @IBOutlet weak var tOneTeamList: UILabel!
    @IBOutlet weak var tTwoTeamList: UILabel!
    @IBOutlet weak var tOneScoreLabel: UILabel!
    var tOneScore = 0
    @IBOutlet weak var tTwoScoreLabel: UILabel!
    var tTwoScore = 0
    @IBOutlet weak var roundNumLabel: UILabel!
    var roundNum = 1
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    
    //Other Stuff
    var playerOrder = Queue<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tOneLabel.text = tOneName
        tTwoLabel.text = tTwoName
        
        tOneScoreLabel.text = tOneScore.description
        tTwoScoreLabel.text = tTwoScore.description
        
        roundNumLabel.text = "Round: " + roundNum.description
        
        createOrigOrder()
        putOrderIntoTable()
        
        setupScores()
        putScoresIntoTable()
        
        setupTeamLists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Push the order to the stack
    func createOrigOrder(){
        for x in 0...tOneNumPlayers+tTwoNumPlayers{
            if(x < tOneNumPlayers){
                playerOrder.push(tOneNames[x])
            }
            if(x < tTwoNumPlayers){
                playerOrder.push(tTwoNames[x])
            }
        }
    }

    //Gets next order and puts it into the table
    func putOrderIntoTable(){
        var finalText = ""
        let firstPerson = playerOrder.pop()
        finalText += "1. " + firstPerson
        let count = playerOrder.count()
        for x in 1...count{
            let temp = playerOrder.pop()
            finalText += "\n" + (x+1).description + ". " + temp
            playerOrder.push(temp)
        }
        playerOrder.push(firstPerson)
        orderLabel.text = finalText
        orderLabel.sizeToFit()
    }
    
    //Zero out all scores
    func setupScores(){
        for _ in 1...tOneNumPlayers{
            tOneScores.append(0)
        }
        for _ in 1...tTwoNumPlayers{
            tTwoScores.append(0)
        }
    }
    
    //Puts all players into the scores table
    func putScoresIntoTable(){
        let allPlayers = tOneNames + tTwoNames
        let allPlayersScores = tOneScores + tTwoScores
        var finalStr = ""
        
        //Sort by highest score
        for _ in 1...allPlayers.count{
            var currentHigh = 0
            var indexHigh = 0
            for x in 0...allPlayers.count-1{
                if(allPlayersScores[x] >= currentHigh && !finalStr.contains(allPlayers[x])){
                    currentHigh = allPlayersScores[x]
                    indexHigh = x
                }
            }
            finalStr += allPlayers[indexHigh] + ": " + allPlayersScores[indexHigh].description + "\n"
        }
        
        finalStr = finalStr.substring(to: finalStr.index(finalStr.endIndex, offsetBy: -1))
        scoresLabel.text = finalStr
        scoresLabel.sizeToFit()
    }
    
    //Put peoples names into the team lists
    func setupTeamLists(){
        var final = ""
        for name in tOneNames{
            final += name + "\n"
        }
        final = final.substring(to: final.index(final.endIndex, offsetBy: -1))
        tOneTeamList.text = final
        tOneTeamList.sizeToFit()
        
        final = ""
        for name in tTwoNames{
            final += name + "\n"
        }
        final = final.substring(to: final.index(final.endIndex, offsetBy: -1))
        tTwoTeamList.text = final
        tTwoTeamList.sizeToFit()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "inputScores"){
            let svc = segue.destination as! ScoringViewController
            
            svc.tOneName = tOneName
            svc.tOneNames = tOneNames
            svc.tTwoName = tTwoName
            svc.tTwoNames = tTwoNames
        }
    }
    
    @IBAction func prepareForUnwindToGame(segue: UIStoryboardSegue){
        roundNum += 1
        roundNumLabel.text = "Round: " + roundNum.description
        roundNumLabel.sizeToFit()
        
        let svc = segue.source as! ScoringViewController
        var tOneScoresIn = svc.tOneFinalScores
        var tTwoScoresIn = svc.tTwoFinalScores
        
        for x in 0...tOneScoresIn.count-1{
            tOneScores[x] += tOneScoresIn[x]
            tOneScore += tOneScoresIn[x]
        }
        tOneScoreLabel.text = tOneScore.description
        for x in 0...tTwoScoresIn.count-1{
            tTwoScores[x] += tTwoScoresIn[x]
            tTwoScore += tTwoScoresIn[x]
        }
        tTwoScoreLabel.text = tTwoScore.description
        
        putScoresIntoTable()
        putOrderIntoTable()
    }

    
    @IBAction func endGamePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "endGame", sender: self)
    }
}


//Queue Struct because Swift sux
struct Queue<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeFirst()
    }
    func count() -> Int {
        return items.count
    }
}
