package ro.usv.rf.labs.lab3;

import java.util.Arrays;
import ro.usv.rf.utils.DistanceUtils;
public class DistanceMatrix {
    private double[][] matDist;
    private double[][] patternSet;


    public DistanceMatrix(double[][] patternSet) {
        matDist = new double[patternSet.length][patternSet.length];
        this.patternSet = patternSet;
        for (int i = 0; i < patternSet.length; i++) {
            for (int j = 0; j < patternSet.length; j++) {

                //matDist[i][j] = DistanceUtils.distEuclid(patternSet[i], patternSet[j]);
                matDist[i][j] = DistanceUtils.cityBlock(patternSet[i], patternSet[j]);
                //matDist[i][j] = DistanceUtils.distCheb(patternSet[i], patternSet[j]);

            }
        }
    }

    public double[][] neighbours( int i)
    {
        double[][] a = new double[this.patternSet.length][patternSet.length];
        System.out.println(patternSet[i][0] + " " + patternSet[i][1]);

        for (double[] lineSet : matDist) {
            for (double vLine : lineSet) {

            }

        }
        return a;
    }
    @Override
    public String toString() {

        String str = new String();

        for (double[] lineSet : matDist) {
            for (double vLine : lineSet) {
                str += String.format("%.2f ", vLine);
            }
            str += "\n";

        }
        return str;

    }
}
