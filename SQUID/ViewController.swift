//  ViewController.swift
//  SQUID
//
//  Created by Theogene Micomyiza on 7/9/19.
//  Copyright © 2019 Theogene Micomyiza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //image view for cards
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    //label for scores
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var rightScore: UILabel!
    @IBOutlet weak var ResultsDisplayLabel: UILabel!
    @IBOutlet weak var HighestScoreLabel: UILabel!
    
    @IBOutlet weak var dealbutton: UIButton!
    
    //variables
    var LeftPlayerScore = 0
    var RightPlayerScore = 0
    var plays = 0
    
    //store highestscore
    //let savedScore = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if plays == 0 {
            leftImageView.image = UIImage(named: "card1")
            rightImageView.image = UIImage(named: "card0")
        }
        
        //reload info that was saved in memory
        load()
    }

    
    
    //restarts the game
    //sets everything to default values
    @IBAction func Restartbutton(_ sender: UIButton) {
        
        if LeftPlayerScore > Int (HighestScoreLabel.text!)! {
                HighestScoreLabel.text = String(LeftPlayerScore)
        }
        
        rightScore.text = String(0)
        leftScore.text = String(0)
        LeftPlayerScore = 0
        RightPlayerScore = 0
        plays = 0
        
        leftImageView.image = UIImage(named: "card1")
        rightImageView.image = UIImage(named: "card0")
        
        ResultsDisplayLabel.textColor = UIColor.green
        ResultsDisplayLabel.text = ""
        
        dealbutton.isEnabled = true
        
        save()
    }
    
    
    //save score on persistent memory
    
    func save()  {
        
        if LeftPlayerScore > Int (HighestScoreLabel.text!)! {
            HighestScoreLabel.text = String(LeftPlayerScore)
        }
        
        UserDefaults.standard.set(HighestScoreLabel.text, forKey: "score")
    }
    
    
    //method to load data from memory
    func load() {
        
        //check if there is data to load from persistent storage
        if let loadedData : String = UserDefaults.standard.value(forKey: "score") as? String {
         HighestScoreLabel.text =  loadedData
         }
    }
    
    
    //Action: Deal button
    @IBAction func Deattap(_ sender: UIButton) {
        
        //random generator
        let Leftnumber = Int.random(in: 2...14)
        let Rightnumber = Int.random(in: 2...14)
        
        
        plays += 1
        
        if plays == 26 {
            //evalutes if the game is over
             sender.isEnabled = false
            
            //Check the winner
            if LeftPlayerScore > RightPlayerScore {
                ResultsDisplayLabel.text? = "YOU WON!"
                ResultsDisplayLabel.textColor = UIColor.red
            }
            
            else if LeftPlayerScore < RightPlayerScore {
                ResultsDisplayLabel.text? = "YOU LOST!"
                ResultsDisplayLabel.textColor = UIColor.red

            }
            
            else {
                ResultsDisplayLabel.text? = "DRAW!"
                ResultsDisplayLabel.textColor = UIColor.red

            }
        }
        
        else {
            //change image on screen
            leftImageView.image = UIImage (named: "card\(Leftnumber)")
            rightImageView.image = UIImage (named: "card\(Rightnumber)")
            
            //assign points
            if(Leftnumber > Rightnumber){
                LeftPlayerScore += 1
                
                //update point on screen
                leftScore.text = String(LeftPlayerScore)
                
            }
            else if (Leftnumber < Rightnumber){
                RightPlayerScore += 1
                
                //update point on screen
                rightScore.text = String (RightPlayerScore)
                
            }
 
        }
        save()
    }
    
    
}

