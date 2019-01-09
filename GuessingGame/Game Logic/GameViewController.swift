//
//  GameViewController.swift
//  GuessingGame
//
//  Created by Alexandr on 12/19/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0


    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var guessValue: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedValue = slider.value.rounded()

        currentValue = Int(roundedValue)
        startNewGame()
    }

    @IBAction func hitMeButton(_ sender: UIButton) {

        let difference = abs(targetValue - currentValue)
        var points = 100 - difference


        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it"
            if difference == 1 {
                points += 51
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }

        score += points

        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })

        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        let roundedValue = sender.value.rounded()
        currentValue = Int(roundedValue)
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        guessValue.text = String(targetValue)
        updateLabels()
    }

    func updateLabels () {
        guessValue.text = String(targetValue)
        currentScore.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

}

