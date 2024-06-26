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
                .background(Color.brown)
                .cornerRadius(10)
                .foregroundColor(.white)
                Divider()
                if let puzzle = currentSudokuPuzzle {
                    HStack {
                        if current_difficulty == 10 {
                            outlinedText("Medium Difficulty", color: .yellow)
                                .padding()
                        } else if current_difficulty == 20 {
                            outlinedText("Hard Difficulty", color: .red)
                                .padding()
                            
                        } else if current_difficulty == 30 {
                            outlinedText("Expert Difficulty", color: .purple)
                                .padding()
                        } else {
                            outlinedText("Easy Difficulty", color: .green)
                                .padding()
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "timer")
                                .foregroundColor(.white) // Change timer icon color to white
                            Text(timeString(from: elapsedTime))
                                .foregroundColor(.white) // Change timer text color to white
                        }
                        .padding()
                    }
                    SudokuPuzzleView(userGrid: $userGrid, puzzle: puzzle, startTime: $startTime, elapsedTime: $elapsedTime)
                        .padding()
                } else {
                    Text("No Sudoku puzzle generated")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .background(
                Image("woodBackground")
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
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
    
    @ViewBuilder
    private func outlinedText(_ text: String, color: Color) -> some View {
        ZStack {
            Text(text)
                .foregroundColor(color)
                .shadow(color: .white, radius: 1, x: 0, y: 0)
            Text(text)
                .foregroundColor(color)
                .overlay(
                    Text(text)
                        .foregroundColor(.clear)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .white.opacity(0)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .mask(Text(text).foregroundColor(.black))
                        )
                        .blur(radius: 0.5)
                )
        }
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
