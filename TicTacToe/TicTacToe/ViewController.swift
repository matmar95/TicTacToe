//
//  ViewController.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit
import AVFoundation
//View controller of homeView
class ViewController: UIViewController {
    @IBOutlet weak var buttonMultiPlayer: UIButton!
    @IBOutlet weak var button3x3: UIButton!
    @IBOutlet weak var buttonAudioOnOff: UIButton!
    @IBOutlet weak var buttonMusicOnOff: UIButton!
    
    var audioState = true
    var musicState = true
    var buttonSound: AVAudioPlayer = AVAudioPlayer()
    var backgroundSound: AVAudioPlayer = AVAudioPlayer()
    
    
    //button to history match
    @IBAction func historyButton(_ sender: Any) {
        if (audioState){
            buttonSound.play()
        }

        let matchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "match") as! MatchViewController
        matchVC.audioState = audioState
        matchVC.musicState = musicState
        backgroundSound.stop()
         self.present(matchVC, animated: true, completion: nil)
    }
    
    //button for check audio
    @IBAction func audioButton(_ sender: AnyObject) {
        if (audioState){
            sender.setImage(UIImage(named: "audioOffIcon.png"), for: UIControlState())
            buttonSound.stop()
            audioState = false
        }else if(audioState == false){
            sender.setImage(UIImage(named: "audioIcon.png"), for: UIControlState())
            audioState = true
        }
    }
    
    //button for check backgroundMusic
    @IBAction func musicButton(_ sender: AnyObject) {
        if (audioState){
            buttonSound.play()
        }
        
        if (musicState){
            sender.setImage(UIImage(named: "musicOffIcon.png"), for: UIControlState())
            backgroundSound.stop()
            musicState = false
        }else {
            sender.setImage(UIImage(named: "musicIcon.png"), for: UIControlState())
            backgroundSound.play()
            musicState = true
        }
        
    }
    
    //initialize Audio and Music
    func initAudio(){
        do{
            let audioButtonPath = Bundle.main.path(forResource: "buttonClick", ofType: "mp3")
            let backgroundMusicPath = Bundle.main.path(forResource: "spotIpad", ofType: "mp3")

            try buttonSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioButtonPath!)as URL)
            
             try backgroundSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath:backgroundMusicPath!)as URL)
        }
        catch{
            print(error)
        }
    }
    
    //button Play
    @IBAction func button1vs1(_ sender: Any) {
        if (audioState){
            buttonSound.play()
        }
        let modalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "insertName") as! insertNameViewController
        
        modalVC.musicState = musicState
        modalVC.audioState = audioState
        backgroundSound.stop()
        self.present(modalVC, animated: true, completion: nil)
    }
    
    //check music
    func checkAudio() {
        if(musicState){
            backgroundSound.play()
        }else{
            buttonMusicOnOff.setImage(UIImage(named: "musicOffIcon.png"), for: UIControlState())
        }
        if (audioState == false) {
            buttonAudioOnOff.setImage(UIImage(named: "audioOffIcon.png"), for: UIControlState())
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudio()
        checkAudio()
        buttonMultiPlayer.layer.cornerRadius = 7.0
        button3x3.layer.cornerRadius=7.0
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}

