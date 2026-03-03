void main() {

    File file = new File("c:\\test.txt");
    StringBuffer content = new StringBuffer();
    try {
        BufferedReader bufferedReader = new BufferedReader (
                new FileReader(file) );
        String line;
        while ((line = bufferedReader.readLine()) != null) {
            content.append(line).append("\n");
        }
        bufferedReader.close();}
    catch (IOException e) {
        e.printStackTrace();
    }
    System.out.println("Contents of file:");
    System.out.println(content.toString());
    System.out.println(readTextFile("steaua.txt") );
    System.out.println ( Arrays.deepToString (
            readStringMatrixFromFileStream ( "steaua.txt"))
    );
}
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
