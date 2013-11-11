package chess;

import chess.pieces.ChessPiece;

import java.io.IOException;
import java.util.List;
import java.util.Set;

public class App {
    public static void main(String[] args) throws IOException, IllegalAccessException, InstantiationException {
        if (args.length < 2) {
            System.out.println("Missing required arguments: moves file name and board file name");
        }

        final String movesFile = args[0];
        final String boardFile = args[1];
        System.out.println(String.format("Loading moves from %s and bord from %s", movesFile, boardFile));
        List<Move> moves = MovesLoader.loadMovesFromFile(movesFile);
        ChessBoard chessBoard = new ChessBoard();
        chessBoard.loadBoardFromFile(boardFile);

        for (Move move : moves) {
            ChessPiece chessPiece = chessBoard.getPieceAt(move.getStartPosition());
            if (chessPiece == null) {
                System.out.println("ILLEGAL");
            }
            else {
                Set<Move> legalMoves = chessPiece.getLegalMoves(chessBoard);
                if (legalMoves.contains(move)) {
                    System.out.println("LEGAL");
                }
                else {
                    System.out.println("ILLEGAL");
                }
            }
        }
    }
}
