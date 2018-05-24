//
//  EndViewController.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit
import Social
import AVFoundation
import CoreData

class EndViewController: UIViewController {
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelScoreX: UILabel!
    @IBOutlet weak var labelScoreO: UILabel!
    @IBOutlet weak var namePlayerX: UILabel!
    @IBOutlet weak var namePlayerO: UILabel!
    
    var winnerString: String!
    var playerX: String? = nil
    var playerO: String? = nil
    var scoreX: Int?
    var scoreO: Int?
    var buttonSound: AVAudioPlayer = AVAudioPlayer()
    var dateFromGame = ""
    var date = ""
    var audioState = true
    var musicState = true
    
    //array for save the match
    var matchArray:[Match] = []
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //button for go to the home view
    @IBAction func homeButton(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! ViewController
        startVC.audioState = audioState
        startVC.musicState = musicState
        self.present(startVC, animated: true, completion: nil)
    }
    
    //share the result on Facebook
    @IBAction func shareFb(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
        {
            let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
            post.setInitialText("I played on TicTacToe and " + winnerString)
            post.add(UIImage(named: "logo.png"))
            self.present(post, animated: true, completion: nil)
        }else{
            showAlert(service: "Facebook")
        }
    }
    
    //share the result on Twitter
    @IBAction func shareTwitter(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
        {
            let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
            post.setInitialText("I played on TicTacToe and " + winnerString)
            post.add(UIImage(named: "logo.png"))
            self.present(post, animated: true, completion: nil)
        }else{
            showAlert(service: "Twitter")
        }

    }
    
    //restart the game
    @IBAction func restartGame(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "game") as! Game3x3ViewController
        vc.stringLabelX = playerX!
        vc.stringLabelO = playerO!
        vc.scoreX = scoreX!
        vc.scoreO = scoreO!
        vc.audioState = audioState
        vc.musicState = musicState
        vc.date = date
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudio()
        homeButton.layer.cornerRadius = 5.0
        restartButton.layer.cornerRadius = 5.0
        label.text = winnerString
        labelScoreX.text = String(describing: scoreX!)
        labelScoreO.text = String(describing: scoreO!)
        namePlayerX.text = playerX
        namePlayerO.text = playerO
        if (dateFromGame != ""){
            fetchData(oldData: dateFromGame)
        }else{
            saveData()
        }
    }
    
    //func that find the current date
    func findDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = formatter.string(from: Date())
    }
    //save match data on coreData
    func saveData() {
        findDate()
        if namePlayerX.text != "" && namePlayerO.text != "" && scoreX != nil && scoreO != nil {
            let newMatch = NSEntityDescription.insertNewObject(forEntityName: "Match", into: context)
            newMatch.setValue(self.namePlayerX!.text, forKey: "playerX")
            newMatch.setValue(self.namePlayerO!.text, forKey: "playerO")
            newMatch.setValue(self.scoreX!, forKey: "scoreX")
            newMatch.setValue(self.scoreO!, forKey: "scoreO")
            newMatch.setValue(date, forKey: "date")
            do{
                try context.save()
            }
            catch{
                print(error)
            }
        }
    }
    
    //fetch the data of current match when the match is restarted
    func fetchData(oldData:String){
        findDate()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Match")
        do {
            let results = try context.fetch(request)
            if results.count>0{
                for result in results as! [NSManagedObject]{
                    if let dataValue = result.value(forKey: "date") as? String {
                        if dataValue == oldData{
                            result.setValue(self.scoreX!, forKey: "scoreX")
                            result.setValue(self.scoreO!, forKey: "scoreO")
                            result.setValue(date, forKey: "date")
                            do{
                                try context.save()
                            }
                            catch{
                                print(error)
                            }
                        }
                    }
                }
            }
        }
        catch{
            print(error)
        }
    }
    //show alert when you are not connect to fb or twitter
    func showAlert(service: String){
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //init audio for the buttons
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
