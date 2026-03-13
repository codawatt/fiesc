package ro.usv.rf.labs.lab3;

import ro.usv.rf.utils.*;
import ro.usv.rf.utils.DistanceUtils;


import java.util.Arrays;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Map;


public class Main {
    public static void main(String[] args){
        double[][] patternSet = FileUtils.readLearningSetFromFile("in_lab3.txt");
        int numberOfPatterns = patternSet.length;
        int numberOfFeatures = patternSet[0].length;
        System.out.println(Arrays.deepToString(patternSet));
        DistanceMatrix dmx = new DistanceMatrix(patternSet);

        double distanta= DistanceUtils.distEuclid(patternSet[0],patternSet[2]);
        double distanta2= DistanceUtils.distCheb(patternSet[0],patternSet[2]);
        double distanta3= DistanceUtils.cityBlock(patternSet[0],patternSet[2]);


        System.out.println(distanta);
        System.out.println(distanta2);
        System.out.println(distanta3);

        System.out.println(dmx);
        dmx.neighbours(1);

    }
}
