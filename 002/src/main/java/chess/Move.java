package chess;

/**
 * User: sellardj
 */
public class Move {
    private ChessCoordinate startPosition;
    private ChessCoordinate endPosition;

    public Move(ChessCoordinate startPosition, ChessCoordinate endPosition) {
        this.startPosition = startPosition;
        this.endPosition = endPosition;
    }

    public Move(char col1, int row1, char col2, int row2) {
        this(new ChessCoordinate(col1, row1), new ChessCoordinate(col2, row2));
    }

    public Move(int x1, int y1, int x2, int y2) {
        this(new GridCoordinate(x1, y1).toChessCoordinate(),
                new GridCoordinate(x2, y2).toChessCoordinate());
    }

    public Move(GridCoordinate start, GridCoordinate end) {
        this(start.toChessCoordinate(), end.toChessCoordinate());
    }

    public ChessCoordinate getStartPosition() {
        return startPosition;
    }

    public void setStartPosition(ChessCoordinate startPosition) {
        this.startPosition = startPosition;
    }

    public ChessCoordinate getEndPosition() {
        return endPosition;
    }

    public void setEndPosition(ChessCoordinate endPosition) {
        this.endPosition = endPosition;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        Move move = (Move) o;

        if (!endPosition.equals(move.endPosition)) {
            return false;
        }
        if (!startPosition.equals(move.startPosition)) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int result = startPosition.hashCode();
        result = 31 * result + endPosition.hashCode();
        return result;
    }

    @Override
    public String toString() {
        return "Move{" +
                "startPosition=" + startPosition +
                ", endPosition=" + endPosition +
                '}';
    }
}
