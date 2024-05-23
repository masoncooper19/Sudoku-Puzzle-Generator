//
//  PuzzleView.swift
//  puzzlegenerate
//
//  Created by Mason Cooper on 2/20/24.
//

import SwiftUI

struct PuzzleView: View {
    @State private var userGrid: [[Int?]] = Array(repeating: Array(repeating: nil, count: 9), count: 9)
    @State private var difficulty: SudokuDifficulty = .random // Default difficulty
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
                    if current_difficulty == 20 {
                        Text("Medium Difficulty")
                            .foregroundStyle(.yellow)
                            .padding()
                    } else if current_difficulty == 30 {
                        Text("Hard Difficulty")
                            .foregroundStyle(.red)
                            .padding()
                    } else {
                        Text("Easy Difficulty")
                            .foregroundStyle(.green)
                            .padding()
                    }
                    SudokuPuzzleView(userGrid: $userGrid, puzzle: puzzle)
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
    }
    
    func generatePuzzle() {
        currentSudokuPuzzle = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            currentSudokuPuzzle = SudokuPuzzle.generateDaily(difficulty: $difficulty.wrappedValue)
        }
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
