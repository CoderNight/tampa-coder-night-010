package chess;

/**
 * User: sellardj
 */
public class ChessCoordinate {
    private char column;
    private int row;


    public ChessCoordinate(char column, int row) {
        this.row = row;
        this.column = column;
    }

    public char getColumn() {
        return column;
    }

    public void setColumn(char column) {
        this.column = column;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public GridCoordinate toArrayCoordinate() {
        return PositionTranslator.chessCoordinateToArrayCoordinate(this);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ChessCoordinate that = (ChessCoordinate) o;

        if (column != that.column) {
            return false;
        }
        if (row != that.row) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) column;
        result = 31 * result + row;
        return result;
    }

    @Override
    public String toString() {
        return "ChessCoordinate{" +
                "column=" + column +
                ", row=" + row +
                '}';
    }
}
