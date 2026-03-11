package ro.usv.rf.labs.lab3;

import ro.usv.rf.utils.FileUtils;

public class Main {

    public static void main(String[] args) {

        double[][] patterns = FileUtils.readLearningSetFromFile("in_lab3.txt");

        DistanceMatrix mDist = new DistanceMatrix(patterns);

        System.out.println(mDist);

        double[][] neighbors = mDist.neighbors(0);

        System.out.println("Neighbors of pattern 0:");

        for (int i = 0; i < neighbors[0].length; i++) {
            System.out.println(
                    "Index: " + (int) neighbors[0][i] +
                            " Distance: " + neighbors[1][i]);
        }
    }
}