//
//  Game3x3ViewController.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit
import AVFoundation

class Game3x3ViewController: UIViewController {
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var buttonAudioOnOff: UIButton!
    @IBOutlet weak var buttonMusicOnOff: UIButton!
    @IBOutlet weak var playerX: UIImageView!
    @IBOutlet weak var playerO: UIImageView!
    @IBOutlet weak var labelPlayerX: UILabel!
    @IBOutlet weak var labelPlayerO: UILabel!
    @IBOutlet weak var line123: UIImageView!
    @IBOutlet weak var line456: UIImageView!
    @IBOutlet weak var line789: UIImageView!
    @IBOutlet weak var line147: UIImageView!
    @IBOutlet weak var line258: UIImageView!
    @IBOutlet weak var line369: UIImageView!
    @IBOutlet weak var line159: UIImageView!
    @IBOutlet weak var line357: UIImageView!
    
    var player: Int? //Cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var buttonSound: AVAudioPlayer = AVAudioPlayer()
    var backgroundSound: AVAudioPlayer = AVAudioPlayer()
    var stringLabelX = ""
    var stringLabelO = ""
    var scoreX = 0
    var scoreO = 0
    var date = ""
    var musicState = true
    var audioState = true
    var buttonState = true
    
    private var brain = gameBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerXRound()
        initAudio()
        checkAudio()
        labelPlayerX.text = stringLabelX
        labelPlayerO.text = stringLabelO
        labelScore.text = "\(scoreX) - \(scoreO)"
        resetLine()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    func playerXRound(){
        player = 1
        playerX.layer.borderColor = UIColor.yellow.cgColor
        playerX.layer.borderWidth = 2.0
        playerX.layer.cornerRadius = 10.0
        playerO.layer.borderWidth = 0
    }
    
    func playerORound(){
        player = 2
        playerO.layer.borderColor = UIColor.yellow.cgColor
        playerO.layer.borderWidth = 2.0
        playerO.layer.cornerRadius = 10.0
        playerX.layer.borderWidth = 0
    }
    
    //initialization audio and busic
    func initAudio(){
        do{
            let audioButtonPath = Bundle.main.path(forResource: "buttonClick", ofType: "mp3")
            let backgroundMusicPath = Bundle.main.path(forResource: "backgroundAudio", ofType: "mp3")
            try buttonSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioButtonPath!)as URL)
            try backgroundSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath:backgroundMusicPath!)as URL)
        }
        catch{
            print(error)
        }
    }
    
    //check audio when view start
    func checkAudio() {
        if (audioState == false) {
            buttonAudioOnOff.setImage(UIImage(named: "audioOffIcon.png"), for: UIControlState())
        }
        
        if(musicState){
            backgroundSound.play()
        }else{
            buttonMusicOnOff.setImage(UIImage(named: "musicOffIcon.png"), for: UIControlState())
        }
    }
    
    //Button that return to home View
    @IBAction func homeButton(_ sender: Any) {
        backgroundSound.stop()
         let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! ViewController
        homeVC.audioState = audioState
        homeVC.musicState = musicState
        
        self.present(homeVC, animated: true, completion: nil)
    }
    
    //button for check Audio
    @IBAction func audioButton(_ sender: AnyObject) {
        if (audioState){
            buttonSound.play()
            sender.setImage(UIImage(named: "audioOffIcon.png"), for: UIControlState())
            audioState = false
        }else if(audioState == false){
            sender.setImage(UIImage(named: "audioIcon.png"), for: UIControlState())
            audioState = true
        }
    }
    
    //button for check Music
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
    
    //action of array of Game Button
    @IBAction func action(_ sender: AnyObject) {
        if (audioState){
            buttonSound.play()
        }
        
        if ((gameState[sender.tag-1] == 0)&&(buttonState))
        {
            gameState[sender.tag-1] = player!
            if (player == 1){
                sender.setImage(UIImage(named: "x.png"), for: UIControlState())
                playerORound()
            }
            else {
                sender.setImage(UIImage(named: "o.png"), for: UIControlState())
                playerXRound()
            }
        }
        brain.checkMove(gameState: gameState)
        if brain.winner != nil {
            buttonState = false
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.drawLine), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(self.setEndGame), userInfo: nil, repeats: false)
        }
    }
    
    //restart match
    @IBAction func restartButton(_ sender: Any) {
        if (audioState){
            buttonSound.play()
        }
        resetLine()
        brain.reset()
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        playerXRound()
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
    }
    //func called when timer finished
    func setEndGame() {
        end(winner: brain.winner!)
    }
    
    //end function that present EndView
    func end(winner: String){
        let endVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
        
        switch winner {
        case "1":
            endVC.winnerString = stringLabelX + " wins! \n 🏆"
            scoreX += 1
        case "2":
            endVC.winnerString = stringLabelO + " wins! \n 🏆"
            scoreO += 1
        default:
            endVC.winnerString = "It's a draw! \n 🤝"
        }
        
        endVC.playerX = stringLabelX
        endVC.playerO = stringLabelO
        endVC.scoreX = scoreX
        endVC.scoreO = scoreO
        endVC.audioState = audioState
        endVC.musicState = musicState
        if (date != ""){
        endVC.dateFromGame = date
        }
        backgroundSound.stop()
        self.present(endVC, animated: true, completion: nil)
    }
 
    //reset the lines of the Game View
    func resetLine(){
        line123.isHidden = true
        line456.isHidden = true
        line789.isHidden = true
        line147.isHidden = true
        line258.isHidden = true
        line369.isHidden = true
        line159.isHidden = true
        line357.isHidden = true
    }
    
    //draw the winner combination line
    func drawLine() {
        if brain.lineNumber != nil {
            switch brain.lineNumber!{
            case "012":
                line123.isHidden = false
            case "345":
                line456.isHidden = false
            case "678":
                line789.isHidden = false
            case "036":
                line147.isHidden = false
            case "147":
                line258.isHidden = false
            case "258":
                line369.isHidden = false
            case "048":
                line159.isHidden = false
            case "246":
                line357.isHidden = false
            default:
                break
            }
        }
    }
    
}

