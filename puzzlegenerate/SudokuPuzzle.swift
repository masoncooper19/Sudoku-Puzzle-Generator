import Foundation

public var current_difficulty = 0

struct SudokuPuzzle {
    let puzzleGrid: [[Int?]]
    let solutionGrid: [[Int]]
    
    // Initialize SudokuPuzzle with puzzleGrid and solutionGrid
    init(puzzleGrid: [[Int?]], solutionGrid: [[Int]]) {
        self.puzzleGrid = puzzleGrid
        self.solutionGrid = solutionGrid
    }
    
    // Function to generate a daily Sudoku puzzle with the specified difficulty
    static func generateDaily(difficulty: SudokuDifficulty) -> SudokuPuzzle {
        var puzzleGrid: [[Int?]] = Array(repeating: Array(repeating: nil, count: 9), count: 9)
        generateRandomPuzzle(&puzzleGrid)
        let solutionGrid: [[Int]] = puzzleGrid.map { $0.compactMap { $0 } }
        
        // Hide some cells to create the puzzle
        for _ in 0..<40 { // Adjust the number of cells to hide as needed
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            puzzleGrid[row][col] = nil
        }
        
        return SudokuPuzzle(puzzleGrid: puzzleGrid, solutionGrid: solutionGrid)
    }
    
    // Function to check if the user's grid matches the solution grid
    func isSolved(userGrid: [[Int?]]) -> Bool {
        for i in 0..<puzzleGrid.count {
            for j in 0..<puzzleGrid[i].count {
                if userGrid[i][j] != solutionGrid[i][j] {
                    return false
                }
            }
        }
        return true
    }
    
    private static func generateRandomPuzzle(_ grid: inout [[Int?]]) {
        let options = [0, 20, 30]
        guard let selected = options.randomElement() else {
            fatalError("Failed to select a difficulty level")
        }
        current_difficulty = selected
        solveSudoku(&grid)
        removeRandomNumbers(&grid, count: selected)
    }
    
    private static func removeRandomNumbers(_ grid: inout [[Int?]], count: Int) {
        var removedCount = 0
        while removedCount < count {
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            if grid[row][col] != nil {
                grid[row][col] = nil
                removedCount += 1
            }
        }
    }
    
    // Backtracking algorithm to solve Sudoku
    private static func solveSudoku(_ grid: inout [[Int?]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == nil {
                    for num in 1...9 {
                        if isValidMove(grid, row, col, num) {
                            grid[row][col] = num
                            if solveSudoku(&grid) {
                                return true
                            }
                            grid[row][col] = nil
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    private static func isValidMove(_ grid: [[Int?]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        // Check if the number is already in the row or column
        for i in 0..<9 {
            if grid[row][i] == num || grid[i][col] == num {
                return false
            }
        }
        
        // Check if the number is already in the 3x3 grid
        let startRow = row - row % 3
        let startCol = col - col % 3
        for i in startRow..<startRow + 3 {
            for j in startCol..<startCol + 3 {
                if grid[i][j] == num {
                    return false
                }
            }
        }
        return true
    }
}

enum SudokuDifficulty: String, CaseIterable {
    case random = "Random"
}
