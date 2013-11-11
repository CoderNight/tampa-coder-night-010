package chess.pieces;

import chess.ChessBoard;
import chess.GridCoordinate;
import chess.Move;

import java.util.HashSet;
import java.util.Set;

/**
 * User: sellardj
 */
public class Knight extends ChessPiece {
    public static final Character BOARD_SYMBOL = 'N';

    @Override
    public Set<Move> getLegalMoves(ChessBoard chessBoard) {
        Set<Move> legalMoves = new HashSet<>();

        int x = getGridCoordinate().getX();
        int y = getGridCoordinate().getY();

        // Forward 2 Right 1
        GridCoordinate testCoordinate = new GridCoordinate(x + 1, (y + (2 * direction)));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Forward 2 Left 1
        testCoordinate = new GridCoordinate(x - 1, (y + (2 * direction)));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Forward 1 Right 2
        testCoordinate = new GridCoordinate(x + 2, (y + direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Forward 1 Left 2
        testCoordinate = new GridCoordinate(x - 2, (y + direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward 2 Right 1
         testCoordinate = new GridCoordinate(x + 1, (y - (2 * direction)));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward 2 Left 1
        testCoordinate = new GridCoordinate(x - 1, (y - (2 * direction)));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward 1 Right 2
        testCoordinate = new GridCoordinate(x + 2, (y - direction));
        if (chessBoard.isInBounds(testCoordinate) && (chessBoard.isCoordinateEmpty(testCoordinate) ||
                chessBoard.isCoordinateOppositionOccupied(testCoordinate, color))) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Backward 1 Left 2
        testCoordinate = new GridCoordinate(x - 2, (y - direction));
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
