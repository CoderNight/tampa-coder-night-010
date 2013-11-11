package chess;

import org.junit.Test;

import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;

/**
 * User: sellardj
 */
public class PositionTranslatorTest {
    @Test
    public void testArrayCoordinateToChessCoordinate() throws Exception {
        ChessCoordinate chessCoordinate =
                PositionTranslator.arrayCoordinateToChessCoordinate(new GridCoordinate(0, 0));
        assertThat(chessCoordinate, is(new ChessCoordinate('a', 8)));

        chessCoordinate = PositionTranslator.arrayCoordinateToChessCoordinate(new GridCoordinate(7, 7));
        assertThat(chessCoordinate, is(new ChessCoordinate('h', 1)));

        chessCoordinate = PositionTranslator.arrayCoordinateToChessCoordinate(new GridCoordinate(3, 7));
        assertThat(chessCoordinate, is(new ChessCoordinate('d', 1)));

        chessCoordinate = PositionTranslator.arrayCoordinateToChessCoordinate(new GridCoordinate(5, 5));
        assertThat(chessCoordinate, is(new ChessCoordinate('f', 3)));
    }

    @Test
    public void testChessCoordinateToArrayCoordinate() throws Exception {
        GridCoordinate gridCoordinate =
                PositionTranslator.chessCoordinateToArrayCoordinate(new ChessCoordinate('a', 8));
        assertThat(gridCoordinate, is(new GridCoordinate(0, 0)));

        gridCoordinate =
                PositionTranslator.chessCoordinateToArrayCoordinate(new ChessCoordinate('h', 1));
        assertThat(gridCoordinate, is(new GridCoordinate(7, 7)));

        gridCoordinate =
                PositionTranslator.chessCoordinateToArrayCoordinate(new ChessCoordinate('d', 1));
        assertThat(gridCoordinate, is(new GridCoordinate(3, 7)));

        gridCoordinate =
                PositionTranslator.chessCoordinateToArrayCoordinate(new ChessCoordinate('f', 3));
        assertThat(gridCoordinate, is(new GridCoordinate(5, 5)));
    }
}
