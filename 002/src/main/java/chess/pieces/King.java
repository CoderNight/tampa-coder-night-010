package chess.pieces;

import chess.ChessBoard;
import chess.GridCoordinate;
import chess.Move;

import java.util.HashSet;
import java.util.Set;

/**
 * User: sellardj
 */
public class King extends ChessPiece {
    public static final Character BOARD_SYMBOL = 'K';

    @Override
    public Set<Move> getLegalMoves(ChessBoard chessBoard) {
        Set<Move> legalMoves = new HashSet<>();

        int x = getGridCoordinate().getX();
        int y = getGridCoordinate().getY();

        // Forward
        GridCoordinate testCoordinate = new GridCoordinate(x, (y + direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Forward Right
        testCoordinate = new GridCoordinate(x + 1, (y + direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Right
        testCoordinate = new GridCoordinate(x + 1, y);
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward Right
        testCoordinate = new GridCoordinate(x + 1, (y - direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward
        testCoordinate = new GridCoordinate(x, (y - direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward Left
        testCoordinate = new GridCoordinate(x - 1, (y - direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Left
        testCoordinate = new GridCoordinate(x - 1, y);
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Forward Left
        testCoordinate = new GridCoordinate(x - 1, (y + direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }
        return legalMoves;
    }

    @Override
    public char getBoardSymbol() {
        return BOARD_SYMBOL;
    }
}
