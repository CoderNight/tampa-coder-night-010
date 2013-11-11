package chess.pieces;

import chess.GridCoordinate;
import chess.ChessBoard;
import chess.Move;
import org.junit.Test;

import java.util.Set;

import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;

/**
 * User: sellardj
 */
public class PawnTest {
    @Test
    public void testGetLegalMoves() throws Exception {
        ChessBoard chessBoard = new ChessBoard();
        chessBoard.loadBoardFromFile("simple_board.txt");

        Pawn pawn = (Pawn) chessBoard.getPieceAt(new GridCoordinate(0, 1));
        Set<Move> moves = pawn.getLegalMoves(chessBoard);

        assertThat(moves, hasSize(2));
        assertThat(moves, containsInAnyOrder(new Move(0, 1, 0, 2), new Move(0, 1, 0, 3)));
    }

    @Test
    public void testGetLegalMovesMax() throws Exception {
        ChessBoard chessBoard = new ChessBoard();
        chessBoard.loadBoardFromFile("simple_board.txt");
        final Pawn oppositionPawn = new Pawn();
        oppositionPawn.setColor(Color.WHITE);
        chessBoard.setPieceAt(oppositionPawn, new GridCoordinate(2, 2));

        final Pawn oppositionPawn2 = new Pawn();
        oppositionPawn2.setColor(Color.WHITE);
        chessBoard.setPieceAt(oppositionPawn2, new GridCoordinate(4, 2));


        Pawn pawn = (Pawn) chessBoard.getPieceAt(new GridCoordinate(3, 1));
        Set<Move> moves = pawn.getLegalMoves(chessBoard);

        assertThat(moves, hasSize(4));
        assertThat(moves, containsInAnyOrder(new Move(3, 1, 3, 2), new Move(3, 1, 3, 3),
                new Move(3, 1, 4, 2), new Move(3, 1, 2, 2)));
    }
}
