import SwiftUI

struct SudokuPuzzleView: View {
    @Binding var userGrid: [[Int?]]
    let puzzle: SudokuPuzzle
    @Binding var startTime: Date?
    @Binding var elapsedTime: TimeInterval
    @State private var isSolved = false
    @State private var isIncorrect = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { i in
                HStack(spacing: 0) {
                    ForEach(0..<3) { j in
                        BoxView(grid: puzzle.puzzleGrid, rowIndex: i * 3, colIndex: j * 3, userGrid: $userGrid)
                    }
                }
            }
            
            Button("Check Solution") {
                if isGridFilled() {
                    self.isSolved = self.puzzle.isSolved(userGrid: self.userGrid)
                    self.isIncorrect = !self.isSolved
                    if self.isSolved {
                        self.startTime = nil // Stop the timer when the puzzle is solved
                    }
                } else {
                    self.isSolved = false
                    self.isIncorrect = false
                }
            }
            .padding()
            .cornerRadius(10)
            .padding()
            
            if isSolved {
                Text("Congratulations! Puzzle Solved in \(timeString(from: elapsedTime))")
                    .foregroundColor(.green)
                    .padding()
            } else if isIncorrect {
                Text("Try again! Incorrect solution.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .cornerRadius(10)
        .onAppear {
            // Initialize userGrid with the same structure as the puzzleGrid
            self.userGrid = puzzle.puzzleGrid
        }
    }
    
    private func isGridFilled() -> Bool {
        for row in userGrid {
            for cell in row {
                if cell == nil {
                    return false
                }
            }
        }
        return true
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct BoxView: View {
    let grid: [[Int?]]
    let rowIndex: Int
    let colIndex: Int
    @Binding var userGrid: [[Int?]]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(rowIndex..<rowIndex+3, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(colIndex..<colIndex+3, id: \.self) { col in
                        CellView(value: self.$userGrid[row][col], isStartingCell: self.grid[row][col] != nil)
                    }
                }
            }
        }
        .border(Color.black)
    }
}

struct CellView: View {
    @Binding var value: Int?
    let isStartingCell: Bool // Indicates whether the cell contains a starting number
    
    var body: some View {
        TextField("", text: Binding<String>(
            get: {
                if let value = self.value {
                    return String(value)
                } else {
                    return ""
                }
            },
            set: { newValue in
                guard !newValue.isEmpty else {
                    // Do not allow deleting starting numbers
                    return
                }
                
                if let intValue = Int(newValue), (1...9).contains(intValue) {
                    // Allow typing only one number
                    self.value = intValue
                }
            }
        ))
        .multilineTextAlignment(.center)
        .frame(width: 30, height: 30)
        .padding(2)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1)
        )
        .keyboardType(.numberPad)
        .foregroundColor(isStartingCell ? Color.blue : Color.black) // Set text color based on isStartingCell
        .disabled(isStartingCell) // Disable editing for starting cells
    }
}
