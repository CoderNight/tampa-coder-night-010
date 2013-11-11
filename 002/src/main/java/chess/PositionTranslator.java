package chess;

/**
 * User: sellardj
 */
public class PositionTranslator {
    // The amount to subtract from the ascii value of a number to convert it into alpha starting with 'a'
    private static final int ASCII_TRANSLATE = 'a' - '0';

    public static ChessCoordinate arrayCoordinateToChessCoordinate(GridCoordinate gridCoordinate) {
        int row = 8 - gridCoordinate.getY();
        char column = (char) (Character.forDigit(gridCoordinate.getX(), 10) + ASCII_TRANSLATE);
        return new ChessCoordinate(column, row);
    }

    public static GridCoordinate chessCoordinateToArrayCoordinate(ChessCoordinate chessCoordinate) {
        int x = chessCoordinate.getColumn() - 'a';
        int y = 8 - chessCoordinate.getRow();
        return new GridCoordinate(x, y);
    }
}
