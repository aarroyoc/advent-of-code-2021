import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Point {
    private final int x;
    private final int y;
    private final int value;

    public Point(int x, int y, int value) {
        this.x = x;
        this.y = y;
        this.value = value;
    }

    public Point(int x, int y, ArrayList<ArrayList<Integer>> map) {
        this.x = x;
        this.y = y;
        this.value = map.get(y).get(x);
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int getValue() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Point point = (Point) o;
        return x == point.x && y == point.y && value == point.value;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, value);
    }
}
