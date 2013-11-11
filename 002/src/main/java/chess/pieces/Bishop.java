package chess.pieces;

import chess.ChessBoard;
import chess.GridCoordinate;
import chess.Move;

import java.util.HashSet;
import java.util.Set;

/**
 * User: sellardj
 */
public class Bishop extends ChessPiece {
    public static final Character BOARD_SYMBOL = 'B';

    @Override
    public Set<Move> getLegalMoves(ChessBoard chessBoard) {
        Set<Move> legalMoves = new HashSet<>();

        int x = getGridCoordinate().getX();
        int y = getGridCoordinate().getY();

        // Forward Right
        GridCoordinate testCoordinate = new GridCoordinate(x + 1, y + direction);
        while (chessBoard.isInBounds(testCoordinate) && !chessBoard.isCoordiateOccupied(testCoordinate)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
            testCoordinate = new GridCoordinate(testCoordinate.getX() + 1, (testCoordinate.getY() + direction));
        }

        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateOppositionOccupied(testCoordinate, color)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Forward Left
        testCoordinate = new GridCoordinate(x - 1, (y + direction));
        while (chessBoard.isInBounds(testCoordinate) && !chessBoard.isCoordiateOccupied(testCoordinate)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
            testCoordinate = new GridCoordinate(testCoordinate.getX() - 1, (testCoordinate.getY() + direction));
        }

        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateOppositionOccupied(testCoordinate, color)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Back Right
        testCoordinate = new GridCoordinate(x + 1, y - direction);
        while (chessBoard.isInBounds(testCoordinate) && !chessBoard.isCoordiateOccupied(testCoordinate)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
            testCoordinate = new GridCoordinate(testCoordinate.getX() + 1, (testCoordinate.getY() - direction));
        }

        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateOppositionOccupied(testCoordinate, color)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        // Back Left
        testCoordinate = new GridCoordinate(x - 1, y - direction);
        while (chessBoard.isInBounds(testCoordinate) && !chessBoard.isCoordiateOccupied(testCoordinate)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
            testCoordinate = new GridCoordinate(testCoordinate.getX() - 1, (testCoordinate.getY() - direction));
        }

        if (chessBoard.isInBounds(testCoordinate) && chessBoard.isCoordinateOppositionOccupied(testCoordinate, color)) {
            legalMoves.add(new Move(this.gridCoordinate, testCoordinate));
        }

        return legalMoves;
    }

    @Override
    public char getBoardSymbol() {
        return BOARD_SYMBOL;
    }
}
