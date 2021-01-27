//
//  ViewController.swift
//  TicTacToe (2)
//
//  Created by Lena Rotteveel on 11/20/19.
//  Copyright © 2019 Lena Rotteveel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var backgroundView2: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    var labelsIsArray = [GridLabel]()
    var xTurn = true
    var gameOver = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelsIsArray.append(gridLabel0)
        labelsIsArray.append(gridLabel1)
        labelsIsArray.append(gridLabel2)
        labelsIsArray.append(gridLabel3)
        labelsIsArray.append(gridLabel4)
        labelsIsArray.append(gridLabel5)
        labelsIsArray.append(gridLabel6)
        labelsIsArray.append(gridLabel7)
        labelsIsArray.append(gridLabel8)
    }
    
    @IBAction func onTappedGridLabel(_ sender: UITapGestureRecognizer) {
        if !gameOver {
            var canPlay = false
            for label in labelsIsArray {
                if label.frame.contains(sender.location(in: backgroundView)) {
                    if label.canTap {
                        if xTurn {
                            label.text = "X"
                        }
                        else {
                            label.text = "O"
                        }
                        xTurn = !xTurn
                        label.canTap = false
                        checkForWinner()
                    }
                }
                if label.canTap {
                    canPlay = true
                }
            }
            if (!canPlay && !gameOver) {
                displayWinningMessage(message: "cat's game")
            }
        }
    }
    
    func checkForWinner() {
        checkLine(a:0 , b:1, c:2) //across
        checkLine(a:3, b:4, c:5)
        checkLine(a:6, b:7, c:8)
        checkLine(a:0, b:4, c:8) //diagonal
        checkLine(a:2, b:4, c:6)
        checkLine(a:6, b:7, c:8)
        checkLine(a:0, b:3, c:6) //up and down
        checkLine(a:1, b:4, c:7)
        checkLine(a:2, b:5, c:8)
    }
    
    func displayWinningMessage(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Reset", style: .default) {
            (action) -> Void in self.resetGame()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        gameOver = true
    }
    
    func checkLine(a: Int, b: Int, c: Int) {
        if labelsIsArray[a].text != "" &&
            labelsIsArray[a].text == labelsIsArray[b].text &&
            labelsIsArray[b].text == labelsIsArray[c].text {
            displayWinningMessage(message: "\(labelsIsArray[a].text!) is the winner!")
        }
    }
    
    func resetGame () {
        for label in labelsIsArray {
            label.text = ""
            label.canTap = true
        }
        xTurn = true
        gameOver = false
    }
}
