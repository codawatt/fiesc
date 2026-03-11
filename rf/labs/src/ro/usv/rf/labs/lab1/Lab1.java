package ro.usv.rf.labs.lab1;

import ro.usv.rf.utils.FileUtils1;
import ro.usv.rf.utils.DataUtils;

import java.util.Arrays;

public class Lab1 {
    public static void main(String[] args) {

        double[][] dataFromFile = FileUtils1.readMatrixFromFileStream("in_lab1.txt");
        double[][] normalizedData = DataUtils.normalizeLearningSet(dataFromFile);


        System.out.println(Arrays.deepToString(dataFromFile));
        System.out.println(Arrays.deepToString(normalizedData));
    }
}
