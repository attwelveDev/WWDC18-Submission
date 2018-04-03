/*
 
 let sayHello = true
 let myName = "Aaron Nguyen"
 let thisIsMyProject = true
 
 print("Welcome to Guess The 📧〽️💣🎷🍦 (Emoji)! I thank you for taking the time to judge my project and hope you enjoy playing and experiencing my creation for WWDC18! Thank you again!")

 let willHaveFun = true
 let enjoymentLevel = 100
 
 */

// MARK: Modules

import UIKit
import AVFoundation
import PlaygroundSupport

// MARK: Extensions

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension Array {
    var shuffled: Array {
        var array = self
        
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            array.swapAt($0, index)
        }
        
        return array
    }
}

extension String {
    var jumble: String {
        return String(Array(self).shuffled)
    }
}

// MARK: Arrays of emojis

let emojiArray = [
    "Letter": "✉",
    "Bags": "🛍",
    "Knife": "🔪",
    "Map": "🗺",
    "Pole": "💈",
    "Timer": "⌛",
    "Watch": "⌚",
    "Clock": "⏰",
    "Thermometer": "🌡",
    "Umbrella": "⛱",
    "Balloon": "🎈",
    "Ribbon": "🎀",
    "Radio": "📻",
    "Phone": "📱",
    "Telephone": "☎",
    "Battery": "🔋",
    "Computer": "💻",
    "Printer": "🖨",
    "Keyboard": "⌨",
    "Mouse": "🖱",
    "DVD": "📀",
    "Television": "📺",
    "Camera": "📷",
    "Candle": "🕯",
    "Lightbulb": "💡",
    "Flashlight": "🔦",
    "Book": "📖",
    "Newspaper": "📰",
    "Money": "💵",
    "Box": "📦",
    "Mailbox": "📪",
    "Pencil": "✏",
    "Pen": "🖊",
    "Folder": "📁",
    "Calendar": "📅",
    "Clipboard": "📋",
    "Ruler": "📏",
    "Lock": "🔒",
    "Key": "🔑",
    "Hammer": "🔨",
    "Shield": "🛡",
    "Telescope": "🔭",
    "Antenna": "📡",
    "Pill": "💊",
    "Door": "🚪",
    "Bed": "🛏",
    "Toilet": "🚽",
    "Shower": "🚿",
    "Bathtub": "🛁",
    "Coffin": "⚰"
]

var usedEmojis = [[String: String]]()

// MARK: UIElement Declarations - baseView

var baseView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
baseView.backgroundColor = .white

let backgroundImageView = UIImageView(frame: baseView.frame)

let viewTitle = UILabel(frame: CGRect(x: baseView.center.x - 250, y: 50, width: 500, height: 40))

let easyButton = UIButton(frame: CGRect(x: baseView.center.x - 51.75, y: baseView.center.y - 55, width: 103.5, height: 30))
let medButton = UIButton(frame: CGRect(x: 0, y: 0, width: 103.5, height: 30))
let hardButton = UIButton(frame: CGRect(x: baseView.center.x - 51.75, y: baseView.center.y + 25, width: 103.5, height: 30))

let instructsButton = UIButton(frame: CGRect(x: baseView.center.x - 51.75, y: 445, width: 103.5, height: 30))

let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.regular))

// MARK: UIElement Declarations - instructsView

var instructsView = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 450))

let instructsTitle = UILabel(frame: CGRect(x: instructsView.center.x - 100, y: 25, width: 200, height: 30))

let instructsText = UITextView(frame: CGRect(x: instructsView.center.x - 200, y: 60, width: 400, height: 250))

let backButton = UIButton(frame: CGRect(x: instructsView.center.x - 51.75, y: 405, width: 103.5, height: 30))

// MARK: gameView declarations

var gameView = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 450))

var buttonTitle = String()
var difficulty = String()

var player: AVAudioPlayer?

let emojiLabel = UILabel(frame: CGRect(x: gameView.center.x - 25, y: 125, width: 50, height: 50))
let emojiImageView = UIImageView(frame: CGRect(x: gameView.center.x - 25, y: 125, width: 50, height: 50))

let stackView = UIStackView(frame: CGRect(x: 10, y: gameView.center.y, width: 430, height: 30))

var hintButton = UIButton(frame: CGRect(x: gameView.center.x - 51.75, y: 405, width: 103.5, height: 30))
var remainingHints = 2

var iconIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
var key = Array(emojiArray.keys)[iconIndex]
var dictValue = Array(emojiArray.values)[iconIndex]
var jumbledKey = key.jumble.lowercased()
var unjumbledAnswers = [String]()

let scoreLabel = UILabel(frame: CGRect(x: gameView.center.x - 50, y: 75, width: 100, height: 20))
var score = 0

let bombLabel = UILabel(frame: CGRect(x: gameView.center.x - 25, y: 25, width: 50, height: 50))
let explosionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

let correctView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
var tapPoint = CGPoint()

let gameOverLabel = UILabel(frame: CGRect(x: gameView.center.x - 100, y: 25, width: 200, height: 30))

let gameOverMessageLabel = UILabel(frame: CGRect(x: gameView.center.x - (gameView.frame.width / 2), y: 60, width: gameView.frame.width, height: 30))

let menuButton = UIButton(frame: CGRect(x: gameView.center.x - 51.75, y: 405, width: 103.5, height: 30))
let againButton = UIButton(frame: CGRect(x: gameView.center.x - 51.75, y: 365, width: 103.5, height: 30))

// MARK: 'Responder' for all functions & targets

class Responder: NSObject {
    @objc func showInstructs() {
        animateIn(blurEffectView)
        animateIn(instructsView)
        
        instructsView.addSubview(instructsTitle)
        instructsView.addSubview(instructsText)
        instructsView.addSubview(backButton)
    }
    
    @objc func hideInstructs() {
        animateOut(blurEffectView)
        animateOut(instructsView)
    }
    
    @objc func firstGame(_ sender: UIButton) {
        animateIn(blurEffectView)
        animateIn(gameView)
        startGame(sender)
    }
    
    @objc func afterFirstGame(_ sender: UIButton) {
        startGame(sender)
    }
    
    func startGame(_ sender: UIButton) {
        playSound("startBellSFX", fileExtension: ".mp3")
        
        gameOverLabel.removeFromSuperview()
        gameOverMessageLabel.removeFromSuperview()
        scoreLabel.removeFromSuperview()
        menuButton.removeFromSuperview()
        againButton.removeFromSuperview()
        
        remainingHints = 2

        gameView.addSubview(bombLabel)
        
        scoreLabel.frame = CGRect(x: 175, y: 75, width: 100, height: 20)
        gameView.addSubview(scoreLabel)
        scoreLabel.font = UIFont.systemFont(ofSize: 15)
        
        buttonTitle = (sender.titleLabel?.text)!
        if buttonTitle == "Again!" {
            newQuestion(difficulty)
        } else {
            difficulty = buttonTitle
            newQuestion(buttonTitle)
        }
        
        score = 0
        scoreLabel.text = "Score: \(score)"
        usedEmojis.removeAll()
    }
    
    @objc func goToMenu() {
        animateOut(blurEffectView)
        animateOut(gameView)
    }
    
    func animateIn(_ view: UIView) {
        baseView.addSubview(view)
        view.center = baseView.center
        
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            view.alpha = 1
            view.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(_ view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            view.alpha = 0
        }) { (success: Bool) in
            view.removeFromSuperview()
        }
    }
    
    func imageFromLabel(_ label: UILabel) -> UIImage {
        let curtain = UIView(frame: CGRect(x: gameView.center.x - 25, y: 125, width: 50, height: 50))
        curtain.alpha = 1
        curtain.backgroundColor = .white
        curtain.center = emojiLabel.center
        
        gameView.addSubview(curtain)
        
        UIView.animate(withDuration: 1) {
            curtain.alpha = 0
        }
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        label.drawHierarchy(in: label.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        emojiImageView.image = image?.withRenderingMode(.alwaysTemplate)
        emojiImageView.tintColor = .black
        gameView.addSubview(emojiImageView)
        
        return image!
    }
    
    @objc func handleTimeOut() {
        expandView(explosionView, duration: 0.25)
        handleGameOver("timeout")
    }
    
    func newQuestion(_ difficulty: String) {
        if difficulty == "Easy" || difficulty == "Medium" {
            perform(#selector(responder.handleTimeOut), with: nil, afterDelay: 10)
        } else {
            perform(#selector(responder.handleTimeOut), with: nil, afterDelay: 5)
        }
        
        emojiLabel.alpha = 1
        
        gameView.addSubview(emojiLabel)
        gameView.addSubview(stackView)
        
        if difficulty == "Medium" || difficulty == "Hard" {
            gameView.addSubview(hintButton)
            hintButton.setTitle("Hint (\(remainingHints))", for: .normal)
            if remainingHints == 0 {
                hintButton.isUserInteractionEnabled = false
            } else {
                hintButton.isUserInteractionEnabled = true
            }
        }
        
        var answers = Set<String>()
        
        iconIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
        key = Array(emojiArray.keys)[iconIndex]
        jumbledKey = key.jumble.lowercased()
        dictValue = Array(emojiArray.values)[iconIndex]
        var dict = [key: dictValue]
        
        while usedEmojis.contains(dict) {
            iconIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
            key = Array(emojiArray.keys)[iconIndex]
            jumbledKey = key.jumble.lowercased()
            dictValue = Array(emojiArray.values)[iconIndex]
            dict = [key: dictValue]
        }
        
        usedEmojis.append(dict)
        
        emojiLabel.text = dictValue
        imageFromLabel(emojiLabel)
        
        unjumbledAnswers.removeAll()
        
        while answers.count <= 2 {
            var answerIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
            var answerKey = Array(emojiArray.keys)[answerIndex]
            while answerKey == key {
                answerIndex = Int(arc4random_uniform(UInt32(emojiArray.count)))
                answerKey = Array(emojiArray.keys)[answerIndex]
            }
            answers.insert(answerKey)
        }
        
        unjumbledAnswers = Array(answers)
        
        var last = unjumbledAnswers.count - 1
        while last > 0 {
            let answerIndex = Int(arc4random_uniform(UInt32(last)))
            unjumbledAnswers.swapAt(last, answerIndex)
            last -= 1
        }

        var jumbledAnswers = [String]()
        for jumbledAnswer in unjumbledAnswers {
            jumbledAnswers.append(jumbledAnswer.lowercased().jumble)
        }
        
        let locationIndex = Int(arc4random_uniform(UInt32(4)))
        jumbledAnswers.insert(jumbledKey, at: locationIndex)
        unjumbledAnswers.insert(key, at: locationIndex)

        var finalAnswers = [String]()
        if difficulty == "Easy" {
            finalAnswers = unjumbledAnswers
        } else {
            finalAnswers = jumbledAnswers
        }
        
        for answer in finalAnswers {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 103.50, height: 30))
            button.addTarget(self, action: #selector(responder.checkAnswer(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(responder.locationChecker(_:forEvent:)), for: .touchUpInside)

            button.setTitle(answer, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
            button.setTitleColor(.black, for: .normal)
            
            roundCornersOf(button, radius: 10, shadows: false)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func showHint() {
        hintButton.removeFromSuperview()
        remainingHints -= 1
        hintButton.isUserInteractionEnabled = true
        
        let firstLetterKey = key.first
        let utterance = AVSpeechUtterance(string: String(firstLetterKey!).lowercased())
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        let synthesiser = AVSpeechSynthesizer()
        synthesiser.speak(utterance)
        
        stackView.removeAllArrangedSubviews()
        for answer in unjumbledAnswers {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 103.50, height: 30))
            button.addTarget(self, action: #selector(responder.checkAnswer(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(responder.locationChecker(_:forEvent:)), for: .touchUpInside)
            
            button.setTitle(answer, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
            button.setTitleColor(.black, for: .normal)
            
            roundCornersOf(button, radius: 10, shadows: false)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func checkAnswer(_ sender: UIButton) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if sender.title(for: .normal) == jumbledKey || sender.title(for: .normal) == key {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10, execute: {
                correctView.center.x = tapPoint.x - 20
                correctView.center.y = tapPoint.y - 275
                self.expandView(correctView, duration: 0.25)
            })
            
            score += 1
            scoreLabel.text = "Score: \(score)"
            
            emojiLabel.alpha = 1

            stackView.removeAllArrangedSubviews()
            
            let label = UILabel(frame: CGRect(x: 10, y: gameView.center.y, width: 430, height: 30))
            label.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
            label.font = .systemFont(ofSize: 14)
            label.textColor = .black
            label.text = key
            label.textAlignment = .center
            roundCornersOf(label, radius: 10, shadows: false)
            label.clipsToBounds = true
            
            stackView.addArrangedSubview(label)
        
            emojiImageView.removeFromSuperview()
            hintButton.removeFromSuperview()
            
            if score != 50 {
                playSound("dingSFX", fileExtension: ".mp3")
            } else {
                playSound("victorySFX", fileExtension: ".mp3")
                
                label.removeFromSuperview()
                emojiLabel.removeFromSuperview()
                stackView.removeAllArrangedSubviews()
                stackView.removeFromSuperview()
                
                self.handleGameOver("complete")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                label.removeFromSuperview()
                emojiLabel.removeFromSuperview()
                stackView.removeAllArrangedSubviews()
                stackView.removeFromSuperview()
                
                if score != 50 {
                    self.newQuestion(difficulty)
                }
            })
        } else {
            expandView(explosionView, duration: 0.25)
            handleGameOver("incorrect")
        }
    }
    
    @objc func locationChecker(_ button: UIButton, forEvent event: UIEvent) {
        guard let touch = event.allTouches?.first else { return }
        tapPoint = touch.location(in: button)
    }
    
    func handleGameOver(_ method: String) {
        bombLabel.removeFromSuperview()
        scoreLabel.removeFromSuperview()
        hintButton.removeFromSuperview()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            gameView.addSubview(gameOverLabel)
            gameView.addSubview(gameOverMessageLabel)
            gameView.addSubview(scoreLabel)
            gameView.addSubview(menuButton)
            gameView.addSubview(againButton)
            gameOverLabel.alpha = 0
            gameOverMessageLabel.alpha = 0
            scoreLabel.alpha = 0
            menuButton.alpha = 0
            againButton.alpha = 0
            
            scoreLabel.frame = CGRect(x: 175, y: 210, width: 100, height: 20)
            scoreLabel.text = "Score: \(score)"
            scoreLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            
            UIView.animate(withDuration: 1.0, animations: {
                gameOverLabel.alpha = 1
                gameOverMessageLabel.alpha = 1
                scoreLabel.alpha = 1
                menuButton.alpha = 1
                againButton.alpha = 1
            })
        })
        
        switch method {
        case "incorrect":
            playSound("explosionSFX", fileExtension: ".mp3")
            gameOverLabel.text = "Game Over!"
            
            if key == "DVD" {
                gameOverMessageLabel.text = "Incorrect. It was \(key) (\(dictValue))."
            } else {
                gameOverMessageLabel.text = "Incorrect. It was \(key.lowercased()) (\(dictValue))."
            }
        case "timeout":
            playSound("explosionSFX", fileExtension: ".mp3")
            gameOverLabel.text = "Game Over!"
                    
            if key == "DVD" {
                gameOverMessageLabel.text = "Timeout. It was \(key) (\(dictValue))."
            } else {
                gameOverMessageLabel.text = "Timeout. It was \(key.lowercased()) (\(dictValue))."
            }
        case "complete":
            gameOverLabel.text = "Diffused!"
            gameOverMessageLabel.text = "You've completed the game!"
        default:
            break
        }
        
        emojiLabel.removeFromSuperview()
        emojiImageView.removeFromSuperview()
        stackView.removeAllArrangedSubviews()
        stackView.removeFromSuperview()
        
    }
    
    func playSound(_ name: String, fileExtension: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func roundCornersOf(_ view: UIView, radius: CGFloat, shadows: Bool) {
        view.layer.cornerRadius = radius
        
        if shadows {
            view.backgroundColor = .white
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.75
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = radius
            view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        }
    }
    
    func expandView(_ view: UIView, duration: TimeInterval) {
        view.transform = CGAffineTransform.identity
        view.alpha = 1
        gameView.addSubview(view)

        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform.init(scaleX: 2000, y: 2000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            UIView.animate(withDuration: 0.50, animations: {
                view.alpha = 0
            }, completion: { (success: Bool) in
                view.removeFromSuperview()
            })
        })
    }
}

let responder = Responder()

// MARK: UIElement Modifications - baseView

backgroundImageView.contentMode = .scaleAspectFill
backgroundImageView.image = UIImage(named: "emojiBackground.jpeg")

viewTitle.text = "Guess The 📧〽️💣🎷🍦!"
viewTitle.font = UIFont.systemFont(ofSize: 30, weight: .black)
viewTitle.textAlignment = .center

easyButton.setTitle("Easy", for: .normal)
easyButton.setTitleColor(UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1), for: .normal)
easyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
easyButton.backgroundColor = .white

responder.roundCornersOf(easyButton, radius: easyButton.frame.height / 2, shadows: true)
easyButton.addTarget(responder, action: #selector(responder.firstGame(_:)), for: .touchUpInside)

medButton.setTitle("Medium", for: .normal)
medButton.setTitleColor(UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1), for: .normal)
medButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
medButton.backgroundColor = .white
responder.roundCornersOf(medButton, radius: medButton.frame.height / 2, shadows: true)
medButton.center = baseView.center
medButton.addTarget(responder, action: #selector(responder.firstGame(_:)), for: .touchUpInside)

hardButton.setTitle("Hard", for: .normal)
hardButton.setTitleColor(UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1), for: .normal)
hardButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
hardButton.backgroundColor = .white
responder.roundCornersOf(hardButton, radius: hardButton.frame.height / 2, shadows: true)
hardButton.addTarget(responder, action: #selector(responder.firstGame(_:)), for: .touchUpInside)

instructsButton.setTitle("Instructions", for: .normal)
instructsButton.setTitleColor(UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1), for: .normal)
instructsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
instructsButton.backgroundColor = .white
responder.roundCornersOf(instructsButton, radius: instructsButton.frame.height / 2, shadows: true)
instructsButton.addTarget(responder, action: #selector(responder.showInstructs), for: .touchUpInside)

blurEffectView.frame = baseView.frame
blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

blurEffectView.alpha = 0

// MARK: UIElement Modifications - instructsView

responder.roundCornersOf(instructsView, radius: 10, shadows: true)
instructsView.center = baseView.center

instructsTitle.text = "Instructions"
instructsTitle.textAlignment = .center
instructsTitle.font = UIFont.systemFont(ofSize: 25, weight: .heavy)

instructsText.text = "The objective is to Guess the Emoji behind the silhouette and select the answer out of the four choices in the given time-frame, which is not shown! When you request a hint in medium and hard levels, the emoji reveals itself, the words unjumble, and the first letter of the answer is spoken. Try to get the correct answer and don’t take too long or else the emoji bomb will explode! You have 50 questions, that if you all get correct, you diffuse the emoji bomb and win the game!\n\nEasy Level: 10 secs, no hint, not jumbled\nMedium Level: 10 secs, two hints, jumbled\nHard Level: 5 secs, two hints, jumbled\n\nHave fun playing Guess the Emoji!"
instructsText.isUserInteractionEnabled = false

backButton.setTitle("OK", for: .normal)
backButton.setTitleColor(.black, for: .normal)
backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
backButton.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
responder.roundCornersOf(backButton, radius: backButton.frame.height / 2, shadows: false)
backButton.addTarget(responder, action: #selector(responder.hideInstructs), for: .touchUpInside)

// MARK: UIElement Modifications - gameView

responder.roundCornersOf(gameView, radius: 10, shadows: true)
gameView.center = baseView.center

emojiLabel.font = .systemFont(ofSize: 45)
emojiLabel.textAlignment = .center

emojiImageView.contentMode = .scaleAspectFit

stackView.spacing = 5
stackView.distribution = .fillEqually

hintButton.setTitle("Hint", for: .normal)
hintButton.setTitleColor(.black, for: .normal)
hintButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
hintButton.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
responder.roundCornersOf(hintButton, radius: hintButton.frame.height / 2, shadows: false)
hintButton.addTarget(responder, action: #selector(responder.showHint), for: .touchUpInside)

bombLabel.text = "💣"
bombLabel.font = .systemFont(ofSize: 25)
bombLabel.textAlignment = .center

scoreLabel.text = "Score: \(score)"
scoreLabel.textAlignment = .center
scoreLabel.textColor = .black
scoreLabel.font = UIFont.systemFont(ofSize: 15)

explosionView.image = UIImage(named: "explosionGradient.jpg")
explosionView.center = bombLabel.center
responder.roundCornersOf(explosionView, radius: explosionView.frame.size.width / 2, shadows: false)
explosionView.clipsToBounds = true

gameOverLabel.text = "Game Over"
gameOverLabel.textAlignment = .center
gameOverLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)

gameOverMessageLabel.textAlignment = .center

correctView.backgroundColor = .green
responder.roundCornersOf(correctView, radius: correctView.frame.size.width / 2, shadows: false)
correctView.clipsToBounds = true

menuButton.setTitle("Menu", for: .normal)
menuButton.setTitleColor(.black, for: .normal)
menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
menuButton.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
responder.roundCornersOf(menuButton, radius: menuButton.frame.height / 2, shadows: false)
menuButton.addTarget(responder, action: #selector(responder.goToMenu), for: .touchUpInside)

againButton.setTitle("Again!", for: .normal)
againButton.setTitleColor(.black, for: .normal)
againButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
againButton.backgroundColor = UIColor(red: 234/255, green: 195/255, blue: 97/255, alpha: 1)
responder.roundCornersOf(againButton, radius: againButton.frame.height / 2, shadows: false)
againButton.addTarget(responder, action: #selector(responder.afterFirstGame(_:)), for: .touchUpInside)

// MARK: Add Views & Initiate Live View

baseView.addSubview(backgroundImageView)
baseView.addSubview(easyButton)
baseView.addSubview(medButton)
baseView.addSubview(hardButton)
baseView.addSubview(instructsButton)
baseView.addSubview(viewTitle)

PlaygroundPage.current.liveView = baseView
