//
//  ViewController.swift
//  DiceRoller
//
//  Created by Fisher Coburn on 11/2/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet var CriticalLabel: UILabel!
    
    
    var rollAudioPlayer: AVAudioPlayer!
    var winAudioPlayer: AVAudioPlayer?
    var lossAudioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rollSound = Bundle.main.path(forResource: "rolldice", ofType: "mp3")
        let winSound = Bundle.main.path(forResource: "zfanfare", ofType: "mp3")
        let lossSound = Bundle.main.path(forResource: "failwah", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let rollSound = rollSound else{
            return
        }
            guard let winSound = winSound else{
            return
        }
            guard let lossSound = lossSound else{
            return
        }
            
            rollAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rollSound))
            winAudioPlayer = try AVAudioPlayer( contentsOf: URL(fileURLWithPath: winSound))
            lossAudioPlayer = try AVAudioPlayer( contentsOf: URL(fileURLWithPath: lossSound))


        }
        catch{
            print(error)
        }
    }
    @IBAction func ButtonGotPressed() {
        rollAudioPlayer?.play()
        rollDice()
    }

    func rollDice() {
        //Cause the dice to change faces
        print("WE ROLLIN IN THIS CRIB")
        
        let rolledNumber = Int.random(in: 1...20)
        
        let imageName = "d\(rolledNumber)"
        
        diceImageView.image = UIImage(named: imageName)
        
        if (imageName == "d1"){
            CriticalLabel.text = "Oof that's an L"
            lossAudioPlayer?.play()
        }
        else if (imageName == "d20"){
            CriticalLabel.text = "Alexa, play 'Turn my Swag On'"
            winAudioPlayer?.play()
        }
        else {
            rollAudioPlayer?.play()
            CriticalLabel.text = ""
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollDice()
    }
}

