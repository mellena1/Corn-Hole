//
//  ScoringViewController.swift
//  Corn Hole
//
//  Created by Andrew Mellen on 1/9/17.
//  Copyright © 2017 Andrew Mellen. All rights reserved.
//

import UIKit

class ScoringViewController: UIViewController {

    var tOneNames:[String]!
    var tOneName:String!
    var tTwoNames:[String]!
    var tTwoName:String!
    
    @IBOutlet var tOneFields: [UITextField]!
    @IBOutlet var tOneNLabels: [UILabel]!
    var tOneFinalScores:[Int] = []
    
    @IBOutlet var tTwoFields: [UITextField]!
    @IBOutlet var tTwoNLabels: [UILabel]!
    var tTwoFinalScores:[Int] = []
    
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamOneLabel.text = tOneName
        teamTwoLabel.text = tTwoName
        
        for x in 0...tOneNLabels.count-1{
            if(x < tOneNames.count){
                tOneNLabels[x].text = tOneNames[x] + ":"
            }
            else{
                tOneNLabels[x].isHidden = true
                tOneFields[x].isHidden = true
            }
        }
        for x in 0...tTwoNLabels.count-1{
            if(x < tTwoNames.count){
                tTwoNLabels[x].text = tTwoNames[x] + ":"
            }
            else{
                tTwoNLabels[x].isHidden = true
                tTwoFields[x].isHidden = true
            }
        }
        
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Get scores from the inputs
    func getTOneScores() -> [Int]{
        var scores:[Int] = []
        for x in 0...tOneNames.count-1{
            scores.append(Int((tOneFields[x].text)!)!)
        }
        return scores
    }
    
    //Get scores from the inputs
    func getTTwoScores() -> [Int]{
        var scores:[Int] = []
        for x in 0...tTwoNames.count-1{
            scores.append(Int((tTwoFields[x].text)!)!)
        }
        return scores
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //Action event for done button
    @IBAction func donePressed(_ sender: UIButton) {
        tOneFinalScores = getTOneScores()
        tTwoFinalScores = getTTwoScores()
        self.performSegue(withIdentifier: "done", sender: self)
    }
}
