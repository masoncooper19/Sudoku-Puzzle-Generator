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
                /*
                Picker("Select Puzzle Type", selection: $puzzleTypeIndex) {
                    ForEach(0..<PuzzleType.allCases.count) { index in
                        Text(PuzzleType.allCases[index].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                 */
                Button("Generate Puzzle") {
                    generatePuzzle()
                }
                .padding()
                Divider()
                /*
                Picker("Select Difficulty", selection: $difficulty) {
                    ForEach(SudokuDifficulty.allCases, id: \.self) { level in
                        Text(level.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: difficulty) { _ in
                    currentSudokuPuzzle = nil
                }
                .padding()
                 */
                if let puzzle = currentSudokuPuzzle {
                    if current_difficulty == 20 {
                        Text("Medium")
                    } else if current_difficulty == 30 {
                        Text("Hard")
                    } else {
                        Text("Easy")
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
