import Foundation
import SwiftUI

class WordGameVM: ObservableObject, KeyboardVMObserver, PauseMenuFunctions {
    
    // constants
    let mode: ActiveView
    let boardSize: Int
    let wordLength: Int
    let difficulty: GameDifficulty
    let date: Date
    
    // Instances of other ViewModels
    var keyboardVM: KeyboardVM = KeyboardVM()
    var gameboardVM: GameboardVM
    var gameOverVM: GameOverVM = GameOverVM()
    var timerVM: TimerVM = TimerVM()
    var pauseVM: PauseVM = PauseVM()
    
    var numValidGuesses: Int = 0
    var numInvalidGuesses: Int = 0
    @Published var exp: Int = 0
    @Published var activeView: ActiveView
    
    var wordsCollection: WordsCollection
    let keyboardModel: KeyboardModel = KeyboardModel()
    
    var componentObservers = [WordGameComponentObserver]()
    var subclassObservers = [WordGameSubclassObserver]()
    
    init(options: GameModeOptions) {
        self.boardSize = options.boardSize
        self.wordLength = options.wordLength
        self.difficulty = options.gameDifficulty
        self.date = Date.now
        
        self.gameboardVM = GameboardVM(boardSize: boardSize, wordLength: wordLength)
        self.wordsCollection = WordsCollection(wordLength: wordLength, wordList: options.wordList)
        self.pauseVM = PauseVM()
        
        self.mode = options.selectedMode
        self.activeView = options.selectedMode
        
        // add self as an observer
        self.keyboardVM.addObserver(observer: self)
        self.addComponentObserver(observer: keyboardVM)
        self.addComponentObserver(observer: gameboardVM)
    }
    
    // Check currentGuess for validity
    private func isValidWord() {
        let guess = gameboardVM.getCurrentGuess()
        let guessWord = guess.getWord()
        var valid = false
        
        guard guess.word.count == self.wordLength else { return }
        
        // first validate the word using the WordsCollection
        if wordsCollection.isValidWord(guessWord) {
            // run the comparison and send it off to the keyboard and gameboard
            let letterBackgrounds = wordsCollection.isSimilarWord(guessWord)
            self.setBackground(guess: guessWord, letterBackgrounds: letterBackgrounds)
            self.numValidGuesses += 1
            valid = true
        } else {
            self.numInvalidGuesses += 1
            guess.invalidWord()
        }
        
        self.notifySubmitGuess(guess: guessWord, valid: valid)
    }
    
    // MARK: Pause Menu Functions
    func pause() {
        self.activeView = .pause
        self.timerVM.pauseTimer()
    }
    
    func quitGame() {
        fatalError("Subclasses must override 'quitGame'")
    }
    
    func back() {
        self.activeView = mode
        self.timerVM.resumeTimer()
    }
    
    // MARK: Keyboard Observer Function
    // Passed the pressed key along to the GameBoardVM if keyboard is in the active state
    func keyPressed(_ key: String) {
        if !timerVM.active {timerVM.startTimer()}
        switch key {
        case FunctionImages.enter:
            self.isValidWord()
        case FunctionImages.delete:
            self.gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.delete)
        default:
            self.gameboardVM.keyPressed(key: key, entryType: KeyboardEntryType.letter)
        }
    }
    
    // MARK: Subclass Observer Functions
    func addSubclassObserver(observer: WordGameSubclassObserver) {
        subclassObservers.append(observer)
    }
    
    func notifySubmitGuess(guess: Word, valid: Bool) {
        for observer in subclassObservers {
            observer.submitGuess(guessWord: guess, valid: valid)
        }
    }
    
    // MARK: Component Observer Functions
    func addComponentObserver(observer: WordGameComponentObserver) {
        self.componentObservers.append(observer)
    }
    
    // notify the keyboard and gameboard that the game has ended and they need to reset their values
    func gameOver() {
        self.numValidGuesses = 0
        self.numInvalidGuesses = 0
        self.exp = 0
        
        for observer in componentObservers {
            observer.gameOver()
        }
    }
    
    // notify the keyboard and the gameboard that they need to update their components backgrounds
    func setBackground(guess:Word, letterBackgrounds: [Color]) {
        for observer in componentObservers {
            observer.setBackground(guess:guess, letterBackgrounds: letterBackgrounds)
        }
    }
}

protocol WordGameSubclassObserver {
    func submitGuess(guessWord : Word, valid: Bool)
}

protocol PauseMenuFunctions {
    func pause()
    func quitGame()
    func back()
}

protocol WordGameComponentObserver {
    func gameOver()
    func setBackground(guess:Word, letterBackgrounds: [Color])
}
