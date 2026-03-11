//package ro.usv.rf.utils;
//import java.util.Arrays;
//import java.util.Dictionary;
//import java.util.Hashtable;
//import java.util.Map;
//
//public class MainClass {
//
//	public static void main(String[] args) {
//		double[][] patternSet = FileUtils.readLearningSetFromFile("in_lab3.txt");
//		int numberOfPatterns = patternSet.length; // randuri
//		int numberOfFeatures = patternSet[0].length; // coloane
//        Dictionary<double[],Integer> weightedMap = new Hashtable<double[], Integer>();
//
//		for (int j=0; j<numberOfFeatures; j++)
//		{
//			double[] feature = new double[numberOfPatterns];
//			for (int i=0; i<numberOfPatterns; i++)
//			{
//				feature[i] = patternSet[i][j];
//
//			}
//			System.out.println("Feature average is:" + StatisticsUtils.calculateFeatureAverage(feature));
//		}
//
//		Map<Pattern, Integer> patternsMap = StatisticsUtils.getPatternsMapFromInitialSet(patternSet);
//
//        for (Map.Entry<Pattern,Integer> p : patternsMap.entrySet())
//        {
//            System.out.println(p);
//        }
//
//
//		double[] weightedAverages = StatisticsUtils.calculateWeightedAverages(patternsMap, numberOfFeatures);
//        System.out.println(Arrays.toString(weightedAverages));
//        double[] dispertion = StatisticsUtils.calculateDispertion(patternsMap, numberOfFeatures);
//        System.out.println(Arrays.toString(dispertion));
//	}
//
//
//}
package ro.usv.rf.labs.lab2;

import ro.usv.rf.utils.FileUtils;
import ro.usv.rf.utils.StatisticsUtils;
import ro.usv.rf.utils.Pattern;
import java.util.Arrays;
import java.util.Map;

public class MainClass {

    public static void main(String[] args) {
        String fileName = args.length > 0 ? args[0] : "in_lab3.txt";
        double[][] patternSet = FileUtils.readLearningSetFromFile(fileName);
        int numberOfFeatures = patternSet[0].length;

        double[] averages = StatisticsUtils.calculateFeatureAverages(patternSet);
        System.out.println("b) Feature averages: " + Arrays.toString(averages));

        Map<Pattern, Integer> patternsMap = StatisticsUtils.getPatternsMapFromInitialSet(patternSet);
        System.out.println("c) Distinct patterns and weights:");
        patternsMap.forEach((pattern, weight) ->
                System.out.println(Arrays.toString(pattern.getPatternValues()) + " -> " + weight));

        double[][] distinctMatrix = StatisticsUtils.convertPatternsMapToMatrix(patternsMap);
        int[] weights = StatisticsUtils.convertPatternsMapToWeightsVector(patternsMap);
        System.out.println("Pattern matrix X:");
        for (double[] row : distinctMatrix) {
            System.out.println(Arrays.toString(row));
        }
        System.out.println("Weights vector f: " + Arrays.toString(weights));

        double[] weightedAverages = StatisticsUtils.calculateWeightedAverages(patternsMap, numberOfFeatures);
        System.out.println("d) Weighted averages: " + Arrays.toString(weightedAverages));

        double[] frequencies = StatisticsUtils.calculateFrequencies(patternsMap);
        System.out.println("e) Frequencies: " + Arrays.toString(frequencies));

        double[] dispersions = StatisticsUtils.calculateFeatureDispersions(patternSet);
        System.out.println("f) Feature dispersions: " + Arrays.toString(dispersions));

        if (numberOfFeatures >= 2) {
            double[] firstFeature = StatisticsUtils.extractFeature(patternSet, 0);
            double[] secondFeature = StatisticsUtils.extractFeature(patternSet, 1);
            double covariance = StatisticsUtils.calculateCovariance(firstFeature, secondFeature);
            double correlation = StatisticsUtils.calculateCorrelationCoefficient(firstFeature, secondFeature);
            System.out.println("g) Covariance between features 1 and 2: " + covariance);
            System.out.println("h) Correlation coefficient between features 1 and 2: " + correlation);
        }

        double[] standardDeviations = StatisticsUtils.calculateStandardDeviations(patternSet);
        System.out.println("i) Standard deviations: " + Arrays.toString(standardDeviations));

        double[][] autoscaledSet = StatisticsUtils.autoscaleFeatures(patternSet);
        System.out.println("j) Autoscaled set:");
        for (double[] row : autoscaledSet) {
            System.out.println(Arrays.toString(row));
        }
    }
}

