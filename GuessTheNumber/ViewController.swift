//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Ömerfaruk Saribal on 1.05.2025.
//

import UIKit

class ViewController: UIViewController {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let button: UIButton = UIButton()
    let textField: UITextField = UITextField()
    var randomNumber: Int = Int.random(in: 1...100)
    var guessCount: Int = 7
    let restartButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        button.addTarget(self, action: #selector(checkGuess), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    }
    @objc func checkGuess() {
        guard let input = textField.text, let guess = Int(input) else {
            titleLabel.text = "⚠️ Please enter a valid number"
            textField.text = ""
            return
        }
        
        if guess == randomNumber {
            titleLabel.text = "🎉 You win!"
            subtitleLabel.text = "👏 Congratulations!"
            endGame()
        } else {
            guessCount -= 1
            
            if guessCount == 0 {
                titleLabel.text = "😭 You lose!"
                subtitleLabel.text = "🔢 The number was \(randomNumber)"
                endGame()
            } else {
                if guess > randomNumber {
                    titleLabel.text = "🔻 The number is lower than \(guess)"
                } else {
                    titleLabel.text = "🔺 The number is higher than \(guess)"
                }
                subtitleLabel.text = "🕐 You have \(guessCount) guesses left"
                textField.text = ""
            }
        }
    }
    
    @objc func restartGame() {
        randomNumber = Int.random(in: 1...100)
        guessCount = 7
        titleLabel.text = "🎯 Guess the number between 1 and 100"
        subtitleLabel.text = "🕐 You have \(guessCount) guesses left"
        textField.isEnabled = true
        textField.isHidden = false
        textField.text = ""
        button.isEnabled = true
        button.isHidden = false
        restartButton.isHidden = true
    }
    
    func endGame() {
        textField.isEnabled = false
        textField.isHidden = true
        button.isEnabled = false
        button.isHidden = true
        restartButton.isHidden = false
    }
    
    func setUI() {
        titleLabel.text = "🎯 Guess the number between 1 and 100"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        subtitleLabel.text = "🕐 You have \(guessCount) guesses left"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        button.setTitle("Guess", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        textField.placeholder = "Enter your guess"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.backgroundColor = .secondarySystemBackground
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        restartButton.setTitle("Play Again", for: .normal)
        restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.backgroundColor = .systemGreen
        restartButton.layer.cornerRadius = 10
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.isHidden = true
        view.addSubview(restartButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            textField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 48),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 48),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 96),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -96),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            restartButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 96),
            restartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -96),
            restartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

