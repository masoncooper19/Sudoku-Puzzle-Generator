# Sudoku Puzzle Generator

## Overview

This Swift project is designed to generate Sudoku puzzles programmatically. Sudoku is a popular logic-based number puzzle game where the objective is to fill a 9×9 grid with digits so that each column, each row, and each of the nine 3×3 subgrids that compose the grid contain all of the digits from 1 to 9.

This Sudoku Puzzle Generator provides functionalities to create Sudoku puzzles with varying levels of difficulty, making it suitable for players of all skill levels.

## Features

- **Sudoku Puzzle Generation**: Generates Sudoku puzzles with a unique solution.
- **Random Difficulty**: Randomly generates puzzles with easy, medium, or hard difficulty levels.
- **Customizable Grid Size**: Provides options to create puzzles of different grid sizes, such as 4x4, 6x6, or 9x9.
- **Solution Verification**: Validates generated puzzles to ensure they have a unique solution.

## Getting Started

### Prerequisites

- Xcode: Ensure you have Xcode installed on your macOS system.
- Swift: This project is written in Swift, so basic knowledge of the Swift programming language is recommended.

### Installation

1. Clone the repository to your local machine:

    ```
    git clone https://github.com/masoncooper19/puzzlegenerate.git
    ```

2. Open the project in Xcode:

    ```
    cd puzzlegenerate
    open puzzlegenerate.xcodeproj
    ```

3. Build and run the project to start generating Sudoku puzzles.

## Usage

### Generating a Sudoku Puzzle

To generate a Sudoku puzzle, run build from ContentView

The difficulty level of the generated puzzle will be random, ranging from easy, medium, to hard.

### Customization Options

- **Grid Size**: By default, the generator creates 9x9 puzzles. For other grid sizes, modify the `puzzleGrid` var in the code.

## Contributing

Contributions are welcome! If you'd like to contribute to this Sudoku Puzzle Generator, please fork the repository and submit a pull request. For major changes, please open an issue first to discuss the proposed changes.

## Acknowledgments

- Inspired by the classic Sudoku puzzle game.
- Built by Mason Cooper.
