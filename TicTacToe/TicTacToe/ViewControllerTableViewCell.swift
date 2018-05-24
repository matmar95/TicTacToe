//
//  ViewControllerTableViewCell.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit


class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scoreX: UILabel!
    @IBOutlet weak var scoreO: UILabel!
    @IBOutlet weak var playerX: UILabel!
    @IBOutlet weak var playerO: UILabel!
    @IBOutlet weak var imageO: UIImageView!
    @IBOutlet weak var imageX: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
