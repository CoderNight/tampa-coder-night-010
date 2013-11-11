package chess.pieces;


/**
 * User: sellardj
 */
public enum Color {
    BLACK('b'), WHITE('w');

    private char colorSymbol;

    Color(char colorSymbol) {
        this.colorSymbol = colorSymbol;
    }

    public char getColorSymbol() {
        return colorSymbol;
    }

    public static Color fromSymbol(Character colorSymbol) {
        if (colorSymbol == 'b') {
            return BLACK;
        } else if (colorSymbol == 'w') {
            return WHITE;
        }
        throw new IllegalArgumentException("colorSymbol was not b or w");
    }
}
