import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class HeightMap {

    private final ArrayList<ArrayList<Integer>> map;

    public HeightMap(ArrayList<ArrayList<Integer>> map) {
        this.map = map;
    }

    public int getRisk() {
        return this.findLowPoints().stream().map(x -> x.getValue() +1).reduce(0, (a,b) -> a + b);
    }

    public int getRiskAdvanced() {
        List<Integer> basins = this.findBasinsSize();
        Collections.sort(basins, Collections.reverseOrder());
        return basins.get(0) * basins.get(1) * basins.get(2);
    }

    private List<Integer> findBasinsSize() {
        ArrayList<Integer> sizes = new ArrayList<>();
        List<Point> lowPoints = this.findLowPoints();
        for(Point p : lowPoints) {
            int size = 0;
            List<Point> toVisit = new ArrayList<>();
            Set<Point> visited = new HashSet<>();
            toVisit.add(p);
            while(toVisit.size() > 0) {
                Point visit = toVisit.get(0);
                toVisit.remove(0);
                if(!visited.contains(visit)) {
                    visited.add(visit);
                    if(visit.getValue() < 9) {
                        size++;
                        if (visit.getX() > 0) {
                            Point n = new Point(visit.getX() - 1, visit.getY(), this.map);
                            toVisit.add(n);
                        }
                        if (visit.getY() > 0) {
                            Point n = new Point(visit.getX(), visit.getY() - 1, this.map);
                            toVisit.add(n);
                        }
                        if (visit.getX() < this.map.get(visit.getY()).size() - 1) {
                            Point n = new Point(visit.getX() + 1, visit.getY(), this.map);
                            toVisit.add(n);
                        }
                        if (visit.getY() < this.map.size() - 1) {
                            Point n = new Point(visit.getX(), visit.getY() + 1, this.map);
                            toVisit.add(n);
                        }
                    }
                }
            }
            sizes.add(size);
        }
        return sizes;
    }


    private List<Point> findLowPoints() {
        ArrayList<Point> lowPoints = new ArrayList<>();
        for(int i = 0; i<this.map.size(); i++){
            for(int j = 0; j< this.map.get(i).size(); j++){
                int value = this.map.get(i).get(j);
                int left = 9;
                if (j > 0) {
                    left = this.map.get(i).get(j-1);
                }
                int right = 9;
                if (j < this.map.get(i).size() - 1) {
                    right = this.map.get(i).get(j+1);
                }
                int up = 9;
                if (i > 0) {
                    up = this.map.get(i - 1).get(j);
                }
                int down = 9;
                if (i < this.map.size() - 1) {
                    down = this.map.get(i + 1).get(j);
                }
                if(value < left && value < right && value < up && value < down) {
                    lowPoints.add(new Point(j, i, value));
                }
            }
        }
        return lowPoints;
    }

    public static HeightMap fromFile(String fileName) throws FileNotFoundException {
        File file = new File(fileName);
        Scanner in = new Scanner(file);
        ArrayList<ArrayList<Integer>> map = new ArrayList<>();
        while(in.hasNextLine()){
            ArrayList<Integer> line = new ArrayList<>();
            for(char c : in.nextLine().toCharArray()) {
                line.add((int)c-48);
            }
            map.add(line);
        }
        return new HeightMap(map);
    }
}
