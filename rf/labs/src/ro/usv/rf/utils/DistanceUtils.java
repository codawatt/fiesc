package ro.usv.rf.utils;

public class DistanceUtils {

    public static double euclidean(double[] x, double[] y) {
        if (x.length != y.length) {
            throw new IllegalArgumentException("Patterns must have same dimension");
        }

        double sum = 0;

        for (int i = 0; i < x.length; i++) {
            sum += Math.pow(x[i] - y[i], 2);
        }

        return Math.sqrt(sum);
    }

    public static double cityBlock(double[] x, double[] y) {
        if (x.length != y.length) {
            throw new IllegalArgumentException("Patterns must have same dimension");
        }

        double sum = 0;

        for (int i = 0; i < x.length; i++) {
            sum += Math.abs(x[i] - y[i]);
        }

        return sum;
    }

    public static double chebyshev(double[] x, double[] y) {
        if (x.length != y.length) {
            throw new IllegalArgumentException("Patterns must have same dimension");
        }

        double max = 0;

        for (int i = 0; i < x.length; i++) {
            double diff = Math.abs(x[i] - y[i]);
            if (diff > max) {
                max = diff;
            }
        }

        return max;
    }
}