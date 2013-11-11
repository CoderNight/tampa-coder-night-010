package chess.pieces;

import chess.GridCoordinate;
import chess.ChessBoard;
import chess.Move;

import java.util.HashSet;
import java.util.Set;

/**
 * User: sellardj
 */
public class Pawn extends ChessPiece {
    public static final Character BOARD_SYMBOL = 'P';

    @Override
    public Set<Move> getLegalMoves(ChessBoard chessBoard) {
        Set<Move> legalMoves = new HashSet<>();

        int x = getGridCoordinate().getX();
        int y = getGridCoordinate().getY();

        GridCoordinate testCoordinate = new GridCoordinate(x, y + direction);
        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateEmpty(testCoordinate)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        GridCoordinate testCoordinate2 = new GridCoordinate(x, (y + (2 * direction)));
        if (isStartPosition() && chessBoard.isInBounds(testCoordinate) && chessBoard.isInBounds(testCoordinate2) &&
                chessBoard.isCoordinateEmpty(testCoordinate) && chessBoard.isCoordinateEmpty(testCoordinate2)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate2));
        }

        testCoordinate = new GridCoordinate(x + 1, y + direction);
        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateOppositionOccupied(testCoordinate, color)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        testCoordinate = new GridCoordinate(x - 1, y + direction);
        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateOppositionOccupied(testCoordinate, color)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        return legalMoves;
    }

    private boolean isStartPosition() {
        if (color == Color.BLACK)
            return gridCoordinate.getY() == 1;
        else
            return gridCoordinate.getY() == 6;
    }


    @Override
    public char getBoardSymbol() {
        return BOARD_SYMBOL;
    }
}
