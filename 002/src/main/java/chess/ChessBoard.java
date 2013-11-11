package chess;

import chess.pieces.Bishop;
import chess.pieces.ChessPiece;
import chess.pieces.Color;
import chess.pieces.King;
import chess.pieces.Knight;
import chess.pieces.Pawn;
import chess.pieces.Queen;
import chess.pieces.Rook;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

/**
 * User: sellardj
 */
public class ChessBoard {
    public static final int GRID_SIZE = 8;
    private ChessPiece[][] board = new ChessPiece[GRID_SIZE][GRID_SIZE];
    private static final Map<Character, Class<? extends ChessPiece>> chessPieceSymbolMap;

    static {
        chessPieceSymbolMap = new HashMap<>();
        chessPieceSymbolMap.put(Pawn.BOARD_SYMBOL, Pawn.class);
        chessPieceSymbolMap.put(Bishop.BOARD_SYMBOL, Bishop.class);
        chessPieceSymbolMap.put(King.BOARD_SYMBOL, King.class);
        chessPieceSymbolMap.put(Knight.BOARD_SYMBOL, Knight.class);
        chessPieceSymbolMap.put(Queen.BOARD_SYMBOL, Queen.class);
        chessPieceSymbolMap.put(Rook.BOARD_SYMBOL, Rook.class);
    }

    public void setPieceAt(ChessPiece chessPiece, ChessCoordinate chessCoordinate) {
        setPieceAt(chessPiece, chessCoordinate.toArrayCoordinate());
    }

    public void setPieceAt(ChessPiece chessPiece, GridCoordinate gridCoordinate) {
        board[gridCoordinate.getY()][gridCoordinate.getX()] = chessPiece;
    }

    public ChessPiece getPieceAt(GridCoordinate gridCoordinate) {
        return board[gridCoordinate.getY()][gridCoordinate.getX()];
    }

    public ChessPiece getPieceAt(ChessCoordinate chessCoordinate) {
        return getPieceAt(chessCoordinate.toArrayCoordinate());
    }

    public boolean isCoordinateEmpty(GridCoordinate gridCoordinate) {
        return getPieceAt(gridCoordinate) == null;
    }

    public boolean isCoordiateOccupied(GridCoordinate gridCoordinate) {
        return getPieceAt(gridCoordinate) != null;
    }

    public boolean isCoordinateOppositionOccupied(GridCoordinate gridCoordinate, Color color) {
        final ChessPiece pieceAt = getPieceAt(gridCoordinate);
        return pieceAt !=null && pieceAt.getColor() != color;
    }

    public boolean isCoordiateFriendOccupied(GridCoordinate gridCoordinate, Color color) {
        final ChessPiece pieceAt = getPieceAt(gridCoordinate);
        return pieceAt != null && pieceAt.getColor() == color;
    }

    public boolean isInBounds(GridCoordinate gridCoordinate) {
        return gridCoordinate.getX() < GRID_SIZE && gridCoordinate.getY() < GRID_SIZE &&
                gridCoordinate.getX() >= 0 && gridCoordinate.getY() >= 0;
    }

    public void loadBoardFromFile(String filename) throws IOException, InstantiationException, IllegalAccessException {
        Path boardPath = Paths.get(filename);
        loadBoard(Files.readAllLines(boardPath, Charset.forName("US-ASCII")));
    }

    public void loadBoard(List<String> boardText) throws IllegalAccessException, InstantiationException {
        int y = 0;
        for (String row : boardText) {
            StringTokenizer pieceTokenizer = new StringTokenizer(row, " ");
            int x = 0;
            while (pieceTokenizer.hasMoreElements()) {
                String piece = pieceTokenizer.nextToken();
                if (piece.equals("--")) {
                    board[y][x] = null;
                }
                else {
                    ChessPiece chessPiece = chessPieceSymbolMap.get(piece.charAt(1)).newInstance();
                    chessPiece.setColor(Color.fromSymbol(piece.charAt(0)));
                    chessPiece.setGridCoordinate(new GridCoordinate(x, y));
                    board[y][x] = chessPiece;
                }
                x++;
            }
            y++;
        }
    }

    public String printBoardToString() throws IOException {
        StringBuilder stringBuilder = new StringBuilder(GRID_SIZE * 2);
        for (int y = 0; y < GRID_SIZE; y++) {
            for (int x = 0; x < GRID_SIZE; x++) {
                ChessPiece chessPiece = board[y][x];
                stringBuilder.append(chessPiece == null ? "--" : chessPiece.getBoardMoniker());
                if (x != GRID_SIZE - 1) {
                    stringBuilder.append(' ');
                }
            }
            stringBuilder.append('\n');
        }
        return stringBuilder.toString();
    }

}
