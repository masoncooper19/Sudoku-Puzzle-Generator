import SwiftUI

struct PuzzleView: View {
    @State private var userGrid: [[Int?]] = Array(repeating: Array(repeating: nil, count: 9), count: 9)
    @State private var difficulty: SudokuDifficulty = .random // Default difficulty
    @State private var startTime: Date? = nil // Add start time
    @State private var elapsedTime: TimeInterval = 0 // Add elapsed time
    
    enum PuzzleType: String, CaseIterable, Identifiable {
        case sudoku = "Sudoku"
        var id: String { self.rawValue }
    }
    
    @State private var puzzleTypeIndex: Int = 0
    @State private var currentSudokuPuzzle: SudokuPuzzle?
    @State private var isMathProblemCorrect: Bool? = nil
    
    private var selectedPuzzleType: PuzzleType {
        PuzzleType.allCases[puzzleTypeIndex]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Generate Puzzle") {
                    generatePuzzle()
                }
                .padding()
                Divider()
                if let puzzle = currentSudokuPuzzle {
                    HStack {
                        if current_difficulty == 10 {
                            Text("Medium Difficulty")
                                .foregroundStyle(.yellow)
                                .padding()
                        } else if current_difficulty == 20 {
                            Text("Hard Difficulty")
                                .foregroundStyle(.red)
                                .padding()
                            
                        } else if current_difficulty == 30 {
                            Text("Expert Difficulty")
                                .foregroundStyle(.purple)
                                .padding()
                        } else {
                            Text("Easy Difficulty")
                                .foregroundStyle(.green)
                                .padding()
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "timer")
                            Text(timeString(from: elapsedTime))
                        }
                        .padding()
                    }
                    SudokuPuzzleView(userGrid: $userGrid, puzzle: puzzle, startTime: $startTime, elapsedTime: $elapsedTime)
                        .padding()
                } else {
                    Text("No Sudoku puzzle generated")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationBarTitle("Sudoku Generator")
            .padding()
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if let startTime = startTime {
                elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    func generatePuzzle() {
        userGrid = Array(repeating: Array(repeating: nil, count: 9), count: 9) // Reset the user grid
        currentSudokuPuzzle = nil
        startTime = Date() // Start the timer
        elapsedTime = 0 // Reset elapsed time
        DispatchQueue.global(qos: .userInitiated).async {
            let newPuzzle = SudokuPuzzle.generateDaily(difficulty: difficulty)
            DispatchQueue.main.async {
                // print("Generated Puzzle Grid: \(newPuzzle.puzzleGrid)")
                currentSudokuPuzzle = newPuzzle
                userGrid = newPuzzle.puzzleGrid // Assign the puzzle grid to userGrid
            }
        }
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
