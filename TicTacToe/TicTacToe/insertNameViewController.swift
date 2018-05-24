//
//  insertNameViewController.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit
import AVFoundation

class insertNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playerX: UITextField!
    @IBOutlet weak var playerO: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var buttonSound: AVAudioPlayer = AVAudioPlayer()
    var audioState = true
    var musicState = true
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //return to homeView
    @IBAction func cancelButton(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! ViewController
        mainVC.audioState = audioState
        mainVC.musicState = musicState
        self.present(mainVC, animated: true, completion: nil)
    }
    
    //action for go to the match View
    @IBAction func playButton(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        if (playerX.text != "") && (playerO.text != ""){
            let gameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "game") as! Game3x3ViewController
            gameVC.stringLabelX = playerX.text!
            gameVC.stringLabelO = playerO.text!
            gameVC.audioState = audioState
            gameVC.musicState = musicState
            
        self.present(gameVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudio()
        self.playerX.delegate = self
        self.playerO.delegate = self
        playButton.layer.cornerRadius = 5.0
        cancelButton.layer.cornerRadius = 5.0
    }
    
    //touchh outsied the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn( _ textField: UITextField) -> Bool{
        playerX.resignFirstResponder()
        playerO.resignFirstResponder()
        return (true)
    }
    
    //init audio 
    func initAudio(){
        do{
            let audioButtonPath = Bundle.main.path(forResource: "buttonClick", ofType: "mp3")
            try buttonSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioButtonPath!)as URL)
        }
        catch{
            print(error)
        }
    }
    
}
