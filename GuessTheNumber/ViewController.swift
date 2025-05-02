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
    let guessButton = UIButton()
    let textField = UITextField()
    let restartButton = UIButton()

    var randomNumber = Int.random(in: 1...100)
    var guessCount = 7

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        guessButton.addTarget(self, action: #selector(checkGuess), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    }

    @objc func checkGuess() {
        guard let input = textField.text, let guess = Int(input) else {
            titleLabel.text = "⚠️ Please enter a valid number"
            textField.text = ""
            return
        }
        // Close the keyboard
        textField.resignFirstResponder()

        if guess == randomNumber {
            showResultAlert(title: "🎉 You win!", message: "👏 Congratulations!")
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
            }
        }
        textField.text = ""
    }

    @objc func restartGame() {
        randomNumber = Int.random(in: 1...100)
        guessCount = 7
        titleLabel.text = "🎯 Guess the number between 1 and 100"
        subtitleLabel.text = "🕐 You have \(guessCount) guesses left"
        textField.isEnabled = true
        textField.isHidden = false
        textField.text = ""
        guessButton.isEnabled = true
        guessButton.isHidden = false
        restartButton.isHidden = true
    }

    func endGame() {
        textField.isEnabled = false
        textField.isHidden = true
        guessButton.isEnabled = false
        guessButton.isHidden = true
        restartButton.isHidden = false
    }

    func showResultAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartGame()
        }))
        present(alert, animated: true)
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

        guessButton.setTitle("Guess", for: .normal)
        guessButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        guessButton.setTitleColor(.white, for: .normal)
        guessButton.backgroundColor = .systemIndigo
        guessButton.layer.cornerRadius = 12
        guessButton.layer.shadowColor = UIColor.black.cgColor
        guessButton.layer.shadowOpacity = 0.1
        guessButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        guessButton.layer.shadowRadius = 4
        guessButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(guessButton)

        textField.placeholder = "Enter your guess"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.backgroundColor = .secondarySystemBackground
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done // Default is Return, with this line it become "done"
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

            guessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 48),
            guessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 96),
            guessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -96),
            guessButton.heightAnchor.constraint(equalToConstant: 50),

            restartButton.topAnchor.constraint(equalTo: guessButton.bottomAnchor, constant: 16),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 96),
            restartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -96),
            restartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
