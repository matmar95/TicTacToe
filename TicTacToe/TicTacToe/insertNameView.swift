//
//  insertNameView.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import UIKit

class insertNameView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
