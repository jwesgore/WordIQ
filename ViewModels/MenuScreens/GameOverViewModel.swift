import Foundation
import SwiftUI

class GameOverVM: ObservableObject {

    @Published var results: GameOverModel
    @Published var title: GuessWord
    @Published var bodyContents: [GameOverStat]
    
    var observers: [GameOverVMObserver]
    
    init(results: GameOverModel = GameOverModel()) {
        self.results = results
        self.observers = [GameOverVMObserver]()
        self.title = GuessWord(wordLength: 8)
        
        self.bodyContents = [GameOverStat]()
    }
    
    // MARK: Modify results
    // Reset all data in view
    func clearResults() {
        self.results = GameOverModel()
        self.title = GuessWord(wordLength: 8)
        self.bodyContents =  [GameOverStat]()
    }
    
    // Receive results from a game
    func setResults(results: GameOverModel) {
        self.results = results
        self.setTitle()
        self.loadBody()
    }
    
    func setTitle() {
        let word: Word = results.win ? Word("YOU WIN!") : Word("YOU LOSE")
        self.title.setWord(word: word)
    }
    
    func setTitleBackground() {
        let background = results.win ? [Color](repeating: Color.LetterBackground.correct, count: 8) : [Color](repeating: Color.LetterBackground.incorrect, count: 8)
        self.title.setBackgroundsWithAnimation(letterBackgrounds: background)
    }
    
    // MARK: Display results
    func loadBody() {
        let correctWordStat = GameOverStat(image: "star.square", label: "Word", value: results.correctWord)
        self.bodyContents.append(correctWordStat)
        
        switch results.gameMode {
        case .standardgame:
            self.loadStandard()
        case .rushgame:
            self.loadRush()
        case .frenzygame:
            self.loadFrenzy()
        case .zengame:
            self.loadZen()
        default:
            break
        }
    }
    
    private func loadStandard() {
        let timeElapsedStat = GameOverStat(image: "timer", label: "Time Elapsed", value: TimerVM.timeToString(results.timeElapsed))
        let numGuessesStat = GameOverStat(image: "number", label: "Number of Guesses", value: String(results.numGuesses))
        
        self.bodyContents.append(timeElapsedStat)
        self.bodyContents.append(numGuessesStat)
    }
    
    private func loadRush() {
        let timeRemainingStat = GameOverStat(image: "timer", label: "Time Remaining", value: TimerVM.timeToString(results.timeRemaining))
        let numGuessesStat = GameOverStat(image: "number", label: "Number of Guesses", value: String(results.numGuesses))
        
        self.bodyContents.append(timeRemainingStat)
        self.bodyContents.append(numGuessesStat)
    }
    
    private func loadFrenzy() {
        let timeElapsedStat = GameOverStat(image: "timer", label: "Time Elapsed", value: TimerVM.timeToString(results.timeElapsed))
        let numCorrectWordsStat = GameOverStat(image: "number", label: "Score", value: String(results.numCorrectWords))
        
        self.bodyContents.append(timeElapsedStat)
        self.bodyContents.append(numCorrectWordsStat)
    }
    
    private func loadZen() {
        let timeElapsedStat = GameOverStat(image: "timer", label: "Time Elapsed", value: TimerVM.timeToString(results.timeElapsed))
        let numGuessesStat = GameOverStat(image: "number", label: "Number of Guesses", value: String(results.numGuesses))
        
        self.bodyContents.append(timeElapsedStat)
        self.bodyContents.append(numGuessesStat)
    }
    
    // MARK: Observer Functions
    func addObserver(observer: GameOverVMObserver) {
        observers.append(observer)
    }
    
    // Used for Play Again button
    func playAgain() {
        for observer in observers {
            observer.playAgain()
        }
    }

    // Used for the Main Menu button
    func mainMenu() {
        for observer in observers {
            observer.mainMenu()
        }
    }
}

struct GameOverStat {
    var image: String
    var label: String
    var value: String
}

protocol GameOverVMObserver {
    func playAgain()
    func mainMenu()
}
