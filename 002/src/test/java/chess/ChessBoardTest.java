package chess;

import org.junit.Test;

import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;

/**
 * User: sellardj
 */
public class ChessBoardTest {

    private static final String TEST_CASE_1_EXPECTED =
            "bR bN bB bQ bK bB bN bR\n" +
            "bP bP bP bP bP bP bP bP\n" +
            "-- -- -- -- -- -- -- --\n" +
            "-- -- -- -- -- -- -- --\n" +
            "-- -- -- -- -- -- -- --\n" +
            "-- -- -- -- -- -- -- --\n" +
            "wP wP wP wP wP wP wP wP\n" +
            "wR wN wB wQ wK wB wN wR\n";

    private static final String TEST_CASE_2_EXPECTED =
            "bK -- -- -- -- bB -- --\n" +
            "-- -- -- -- -- bP -- --\n" +
            "-- bP wR -- wB -- bN --\n" +
            "wN -- bP bR -- -- -- wP\n" +
            "-- -- -- -- wK wQ -- wP\n" +
            "wR -- bB wN wP -- -- --\n" +
            "-- wP bQ -- -- wP -- --\n" +
            "-- -- -- -- -- wB -- --\n";

    @Test
    public void testLoadBoard() throws Exception {
        ChessBoard chessBoard = new ChessBoard();
        chessBoard.loadBoardFromFile("simple_board.txt");
        String output = chessBoard.printBoardToString();
        assertThat(output, is(TEST_CASE_1_EXPECTED));
    }

    @Test
    public void testLoadComplexBoard() throws Exception {
        ChessBoard chessBoard = new ChessBoard();
        chessBoard.loadBoardFromFile("complex_board.txt");
        String output = chessBoard.printBoardToString();
        assertThat(output, is(TEST_CASE_2_EXPECTED));
    }

}
