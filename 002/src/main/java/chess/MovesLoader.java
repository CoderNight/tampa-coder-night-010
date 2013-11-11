package chess;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * User: sellardj
 */
public class MovesLoader {
    public static List<Move> loadMovesFromFile(String fileName) throws IOException {
        List<Move> moves = new ArrayList<>();
        Stream<String> lines = Files.lines(Paths.get(fileName));
        lines.forEach(line -> {
            String[] tokens = line.split(" ");
            String startCoord = tokens[0];
            String endCoord = tokens[1];
            moves.add(new Move(new ChessCoordinate(startCoord.charAt(0), Integer.parseInt(startCoord.substring(1))),
                    new ChessCoordinate(endCoord.charAt(0), Integer.parseInt(endCoord.substring(1)))));
        });

        return moves;
    }
}
