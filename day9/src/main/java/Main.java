import java.io.FileNotFoundException;
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        try {
            HeightMap sample = HeightMap.fromFile(Main.class.getResource("input").getFile());
            int risk = sample.getRisk();
            System.out.println("Solution 1: "+risk);
            int risk2 = sample.getRiskAdvanced();
            System.out.println("Solution 2: "+risk2);

        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        }
    }
}
