package chess.pieces;

import chess.GridCoordinate;
import chess.ChessBoard;
import chess.Move;

import java.util.Set;

/**
 * User: sellardj
 */
public abstract class ChessPiece {
    protected Color color;
    protected GridCoordinate gridCoordinate;
    protected int direction = -1;

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
        this.direction = getColor() == Color.BLACK ? 1 : -1;
    }

    public GridCoordinate getGridCoordinate() {
        return gridCoordinate;
    }

    public void setGridCoordinate(GridCoordinate gridCoordinate) {
        this.gridCoordinate = gridCoordinate;
    }

    public abstract Set<Move> getLegalMoves(ChessBoard chessBoard);

    public String getBoardMoniker() {
        return new StringBuilder(2).append(getColor().getColorSymbol()).append(getBoardSymbol()).toString();
    }

    public abstract char getBoardSymbol();

}
