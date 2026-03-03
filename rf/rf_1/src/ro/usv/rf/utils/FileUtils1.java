package ro.usv.rf.utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.stream.Stream;

public class FileUtils1 {

    private static final String inputFileValuesSeparator = "[ \t]";
    private static final String outputFileValuesSeparator = ",";


    public static String readTextFile (String fileName) {
        StringBuffer content = new StringBuffer();

        try (Stream<String> fileStream =
                     Files.lines(Paths.get(fileName))) {

            fileStream.forEach(line ->
                    content.append(line).append("\n") );

        } catch (IOException e) {
            e.printStackTrace();
        }

        return content.toString();
    }

    public static String[][] readStringMatrixFromFileStream (
            String fileName) {
        try (Stream<String> stream =
                     Files.lines(Paths.get(fileName)) )
        {
            return
                    stream
                            .map(line -> line.split("\\s+"))
                            .toArray(String[][]::new);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    public static double[][] readMatrixFromFileStream(String fileName)
    {
        double[][] matrix=null;
        try ( Stream<String> streamLiniiFisier = Files.lines(Paths.get(fileName))) {
            matrix = streamLiniiFisier
                    .map(linie ->
                            Arrays.stream(linie.split(inputFileValuesSeparator))
                                    .filter(x -> !x.isEmpty())
                                    .mapToDouble(Double::parseDouble)
                                    .toArray()
                    )
                    .filter(linMatrice -> linMatrice.length != 0)
                    .toArray(double[][]::new);
        } catch (IOException e){
            e.printStackTrace();
        }
        return matrix;
    }
    public static void writePatternSetToFile(String fileName,double[][] patternMatrix, String fieldSeparator) {
        // TODO:
        // first create the output to be written in a StringBuilder object
        // replace fieldSeparator at the end of each row by \n
        StringBuilder stringBuilder = new StringBuilder();
        try {
            Files.write ( Paths.get(fileName),
                    stringBuilder.toString().getBytes());
        } catch (IOException e) {

            e.printStackTrace();

        }
    }
}
