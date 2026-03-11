package ro.usv.rf.labs.lab3;

import ro.usv.rf.utils.DistanceUtils;
import java.util.Arrays;
import java.util.Comparator;
import java.util.stream.IntStream;

public class DistanceMatrix {

    private double[][] matDist;
    private double[][] patterns;

    public DistanceMatrix(double[][] patterns) {
        this.patterns = patterns;

        int n = patterns.length;
        matDist = new double[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {

                double d;

                if (i == j) {
                    d = 0;
                } else {
                    d = DistanceUtils.euclidean(patterns[i], patterns[j]);
                }

                matDist[i][j] = d;
                matDist[j][i] = d; // symmetry
            }
        }
    }

    public double[][] neighbors(int i) {

        int n = matDist.length;

        Integer[] indices = IntStream.range(0, n).boxed().toArray(Integer[]::new);

        Arrays.sort(indices, Comparator.comparingDouble(j -> matDist[i][j]));

        double[][] result = new double[2][n];

        for (int k = 0; k < n; k++) {
            result[0][k] = indices[k];
            result[1][k] = matDist[i][indices[k]];
        }

        return result;
    }

    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < matDist.length; i++) {
            for (int j = 0; j < matDist[i].length; j++) {
                sb.append(String.format("%.2f", matDist[i][j])).append(" ");
            }
            sb.append("\n");
        }

        return sb.toString();
    }
}