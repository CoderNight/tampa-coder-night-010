package chess.pieces;

import chess.ChessBoard;
import chess.Move;

import java.util.HashSet;
import java.util.Set;

/**
 * User: sellardj
 */
public class Queen extends ChessPiece {
    public static final Character BOARD_SYMBOL = 'Q';

    @Override
    public Set<Move> getLegalMoves(ChessBoard chessBoard) {
        Set<Move> legalMoves = new HashSet<>();
        // Cheat
        Rook rook = new Rook();
        rook.setColor(color);
        rook.setGridCoordinate(gridCoordinate);
        legalMoves.addAll(rook.getLegalMoves(chessBoard));

        Bishop bishop = new Bishop();
        bishop.setColor(color);
        bishop.setGridCoordinate(gridCoordinate);
        legalMoves.addAll(bishop.getLegalMoves(chessBoard));

        return legalMoves;
    }

    @Override
    public char getBoardSymbol() {
        return BOARD_SYMBOL;
    }
}
