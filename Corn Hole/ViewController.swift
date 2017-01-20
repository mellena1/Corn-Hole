//
//  ViewController.swift
//  Corn Hole
//
//  Created by Andrew Mellen on 1/8/17.
//  Copyright © 2017 Andrew Mellen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    //Team One
    @IBOutlet weak var teamOnePlayers: UILabel!
    var numTeamOnePlayers = 0
    var teamOneNameStr = ""
    @IBOutlet weak var teamOneName: UITextField!
    @IBOutlet weak var teamOneStepper: UIStepper!
    @IBOutlet var tOneTextFields: [UITextField]!
    var playerOneNames:[String] = []
    
    //Team Two
    @IBOutlet weak var teamTwoPlayers: UILabel!
    var numTeamTwoPlayers = 0
    var teamTwoNameStr = ""
    @IBOutlet weak var teamTwoName: UITextField!
    @IBOutlet weak var teamTwoStepper: UIStepper!
    @IBOutlet var tTwoTextFields: [UITextField]!
    var playerTwoNames:[String] = []

    //Other
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        updateSteppers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Action event for team one stepper
    @IBAction func teamOneStepperChanged(_ sender: UIStepper) {
        updateStepperOne(stepVal: sender.value)
    }
    
    //Action event for team two stepper
    @IBAction func teamTwoStepperChanged(_ sender: UIStepper) {
        updateStepperTwo(stepVal: sender.value)
    }
    
    //Update the int vals and update the labels
    func updateSteppers(){
        updateStepperOne(stepVal: teamOneStepper.value)
        updateStepperTwo(stepVal: teamTwoStepper.value)
    }
    
    //Updates all the stepperOne stuff
    func updateStepperOne(stepVal:Double){
        numTeamOnePlayers = Int(stepVal)
        teamOnePlayers.text = numTeamOnePlayers.description
        for x in 0...tOneTextFields.count-1{
            if(x < numTeamOnePlayers){
                tOneTextFields[x].isHidden = false
            }
            else{
                tOneTextFields[x].isHidden = true
            }
        }
    }
    
    //Updates all the stepperTwo stuff
    func updateStepperTwo(stepVal:Double){
        numTeamTwoPlayers = Int(stepVal)
        teamTwoPlayers.text = numTeamTwoPlayers.description
        for x in 0...tTwoTextFields.count-1{
            if(x < numTeamTwoPlayers){
                tTwoTextFields[x].isHidden = false
            }
            else{
                tTwoTextFields[x].isHidden = true
            }
        }
    }
    
    //Get names from an array of text fields
    func getNames(textFields: [UITextField]) -> Array<String>{
        var names:[String] = []
        for textField in textFields{
            if(!textField.isHidden){
                names.append(textField.text!)
            }
        }
        return names
    }
    
    //Segue stuff
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "startGame"){
            let svc = segue.destination as! GameViewController
            
            //Get team names
            teamOneNameStr = teamOneName.text!
            teamTwoNameStr = teamTwoName.text!
            
            //Get the names of the players
            playerOneNames = getNames(textFields: tOneTextFields)
            playerTwoNames = getNames(textFields: tTwoTextFields)
            
            svc.tOneNames = playerOneNames
            svc.tOneName = teamOneNameStr
            svc.tOneNumPlayers = numTeamOnePlayers
            svc.tTwoNames = playerTwoNames
            svc.tTwoName = teamTwoNameStr
            svc.tTwoNumPlayers = numTeamTwoPlayers
        }
    }
 
    @IBAction func prepareForUnwindToMain(segue: UIStoryboardSegue){}
}

//Make keyboard disappear thingy
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
