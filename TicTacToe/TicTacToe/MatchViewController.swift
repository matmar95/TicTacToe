//
//  MatchViewController.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

//View Controller for table off all history match from CoreData
class MatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var matchArray:[Match] = []
    var audioState = true
    var musicState = true
    var buttonSound: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var tableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // action for return to home
    @IBAction func backButton(_ sender: Any) {
        if(audioState){
            buttonSound.play()
        }
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! ViewController
        homeVC.audioState = audioState
        homeVC.musicState = musicState
        self.present(homeVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        initAudio()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (matchArray.count)
    }
    
    // creation cell from array of Match
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewControllerTableViewCell
        let match = matchArray[indexPath.row]
        cell.imageX.image = UIImage(named: "x")
        cell.imageO.image = UIImage(named: "o")
        cell.layer.cornerRadius = 30
        cell.playerX.text = match.playerX!
        cell.playerO.text = match.playerO!
        cell.scoreX.text = String(match.scoreX)
        cell.scoreO.text = String(match.scoreO)
        cell.dataLabel.text = match.date!
        
        return (cell)
    }
    
    
    //fetch data from dataModel
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            matchArray = try context.fetch(Match.fetchRequest())
        }catch{
            print(error)
        }
        
        matchArray = matchArray.reversed()
    }
    
    //init audio of button Sound
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
