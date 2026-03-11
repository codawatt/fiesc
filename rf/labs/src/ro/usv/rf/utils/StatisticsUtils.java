//package ro.usv.rf.utils;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Map;
//
//public class StatisticsUtils {
//
//	public static double calculateFeatureAverage(double[] feature)
//	{
//		double average = 0.0;
//		for (int i=0; i<feature.length; i++)
//		{
//			average += feature[i];
//		}
//		average = average/feature.length;
//		return average;
//	}
//
//	public static Map<Pattern, Integer> getPatternsMapFromInitialSet(double[][] patternSet) {
//		Map<Pattern, Integer> patternsMap = new HashMap<Pattern, Integer>();
//		for (int i=0; i<patternSet.length; i++)
//        {
//            Pattern p = new Pattern(patternSet[i]);
//            if (patternsMap.containsKey(p))
//            {
//                patternsMap.put(p,patternsMap.get(p)+1);
//
//            }
//            else {
//                patternsMap.put(p,1);
//            }
//
//        }
//		return patternsMap;
//	}
//
//	public static double[] calculateWeightedAverages(Map<Pattern, Integer> patternsMap, int numberOfFeatures) {
//		double[]  weightedAverages = new double[numberOfFeatures];
//        int numberOfPatterns = 0;
//		for (Map.Entry<Pattern,Integer> p : patternsMap.entrySet())
//        {
//            double[] pattern_key =  p.getKey().getPatternValues();
//            numberOfPatterns += p.getValue();
//            for ( int i=0; i<pattern_key.length;i++)
//            {
//                weightedAverages[i] += pattern_key[i] * p.getValue();
//            }
//
//        }
//        for ( int i=0; i<numberOfFeatures;i++)
//        {
//            weightedAverages[i] = weightedAverages[i] / numberOfPatterns;
//        }
//		return weightedAverages;
//	}
//    public static double[] calculateDispertion(Map<Pattern, Integer> patternsMap, int numberOfFeatures) {
//        double[]  weightedAverages = calculateWeightedAverages(patternsMap,numberOfFeatures);
//        double[] dispersion = new double[numberOfFeatures];
//        int numberOfPatterns = 0;
//        for (Map.Entry<Pattern,Integer> p : patternsMap.entrySet())
//        {
//            double[] pattern_key =  p.getKey().getPatternValues();
//            numberOfPatterns += p.getValue();
//            for ( int i=0; i<pattern_key.length;i++)
//            {
//                dispersion[i] += (pattern_key[i] - weightedAverages[i]) * (pattern_key[i] - weightedAverages[i]) * p.getValue();
//            }
//
//        }
//        for ( int i=0; i<numberOfFeatures;i++)
//        {
//            dispersion[i] = dispersion[i] / (numberOfPatterns-1);
//        }
//        return dispersion;
//    }
//}
//
//
package ro.usv.rf.utils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class StatisticsUtils {

    public static double calculateFeatureAverage(double[] feature) {
        double average = 0.0;
        for (double value : feature) {
            average += value;
        }
        return average / feature.length;
    }

    public static Map<Pattern, Integer> getPatternsMapFromInitialSet(double[][] patternSet) {
        Map<Pattern, Integer> patternsMap = new LinkedHashMap<Pattern, Integer>();
        for (double[] row : patternSet) {
            Pattern pattern = new Pattern(Arrays.copyOf(row, row.length));
            patternsMap.put(pattern, patternsMap.getOrDefault(pattern, 0) + 1);
        }
        return patternsMap;
    }

    public static double[] calculateWeightedAverages(Map<Pattern, Integer> patternsMap, int numberOfFeatures) {
        double[] weightedAverages = new double[numberOfFeatures];
        int totalWeight = getTotalWeight(patternsMap);

        for (Map.Entry<Pattern, Integer> entry : patternsMap.entrySet()) {
            double[] values = entry.getKey().getPatternValues();
            int weight = entry.getValue();
            for (int j = 0; j < numberOfFeatures; j++) {
                weightedAverages[j] += values[j] * weight;
            }
        }

        for (int j = 0; j < numberOfFeatures; j++) {
            weightedAverages[j] /= totalWeight;
        }
        return weightedAverages;
    }

    public static double[] calculateFeatureAverages(double[][] patternSet) {
        int numberOfPatterns = patternSet.length;
        int numberOfFeatures = patternSet[0].length;
        double[] averages = new double[numberOfFeatures];

        for (int j = 0; j < numberOfFeatures; j++) {
            double[] feature = new double[numberOfPatterns];
            for (int i = 0; i < numberOfPatterns; i++) {
                feature[i] = patternSet[i][j];
            }
            averages[j] = calculateFeatureAverage(feature);
        }
        return averages;
    }

    public static double[] calculateFrequencies(Map<Pattern, Integer> patternsMap) {
        int totalWeight = getTotalWeight(patternsMap);
        double[] frequencies = new double[patternsMap.size()];
        int index = 0;

        for (int weight : patternsMap.values()) {
            frequencies[index++] = (double) weight / totalWeight;
        }
        return frequencies;
    }

    public static double calculateFeatureDispersion(double[] feature) {
        double average = calculateFeatureAverage(feature);
        double sum = 0.0;

        for (double value : feature) {
            sum += Math.pow(value - average, 2);
        }
        return sum / (feature.length - 1);
    }

    public static double[] calculateFeatureDispersions(double[][] patternSet) {
        int numberOfPatterns = patternSet.length;
        int numberOfFeatures = patternSet[0].length;
        double[] dispersions = new double[numberOfFeatures];

        for (int j = 0; j < numberOfFeatures; j++) {
            double[] feature = new double[numberOfPatterns];
            for (int i = 0; i < numberOfPatterns; i++) {
                feature[i] = patternSet[i][j];
            }
            dispersions[j] = calculateFeatureDispersion(feature);
        }
        return dispersions;
    }

    public static double calculateCovariance(double[] firstFeature, double[] secondFeature) {
        if (firstFeature.length != secondFeature.length) {
            throw new IllegalArgumentException("Features must have the same length.");
        }

        double firstAverage = calculateFeatureAverage(firstFeature);
        double secondAverage = calculateFeatureAverage(secondFeature);
        double sum = 0.0;

        for (int i = 0; i < firstFeature.length; i++) {
            sum += (firstFeature[i] - firstAverage) * (secondFeature[i] - secondAverage);
        }
        return sum / (firstFeature.length - 1);
    }

    public static double calculateCorrelationCoefficient(double[] firstFeature, double[] secondFeature) {
        double covariance = calculateCovariance(firstFeature, secondFeature);
        double firstDispersion = calculateFeatureDispersion(firstFeature);
        double secondDispersion = calculateFeatureDispersion(secondFeature);

        return covariance / Math.sqrt(firstDispersion * secondDispersion);
    }

    public static double[] calculateStandardDeviations(double[][] patternSet) {
        double[] dispersions = calculateFeatureDispersions(patternSet);
        double[] standardDeviations = new double[dispersions.length];

        for (int j = 0; j < dispersions.length; j++) {
            standardDeviations[j] = Math.sqrt(dispersions[j]);
        }
        return standardDeviations;
    }

    public static double[][] autoscaleFeatures(double[][] patternSet) {
        int numberOfPatterns = patternSet.length;
        int numberOfFeatures = patternSet[0].length;
        double[] averages = calculateFeatureAverages(patternSet);
        double[] standardDeviations = calculateStandardDeviations(patternSet);
        double[][] autoscaledSet = new double[numberOfPatterns][numberOfFeatures];

        for (int i = 0; i < numberOfPatterns; i++) {
            for (int j = 0; j < numberOfFeatures; j++) {
                if (standardDeviations[j] == 0.0) {
                    autoscaledSet[i][j] = 0.0;
                } else {
                    autoscaledSet[i][j] = (patternSet[i][j] - averages[j]) / standardDeviations[j];
                }
            }
        }
        return autoscaledSet;
    }

    public static double[] extractFeature(double[][] patternSet, int featureIndex) {
        double[] feature = new double[patternSet.length];
        for (int i = 0; i < patternSet.length; i++) {
            feature[i] = patternSet[i][featureIndex];
        }
        return feature;
    }

    public static int getTotalWeight(Map<Pattern, Integer> patternsMap) {
        int totalWeight = 0;
        for (int weight : patternsMap.values()) {
            totalWeight += weight;
        }
        return totalWeight;
    }

    public static double[][] convertPatternsMapToMatrix(Map<Pattern, Integer> patternsMap) {
        double[][] matrix = new double[patternsMap.size()][];
        int index = 0;
        for (Pattern pattern : patternsMap.keySet()) {
            matrix[index++] = Arrays.copyOf(pattern.getPatternValues(), pattern.getPatternValues().length);
        }
        return matrix;
    }

    public static int[] convertPatternsMapToWeightsVector(Map<Pattern, Integer> patternsMap) {
        int[] weights = new int[patternsMap.size()];
        int index = 0;
        for (int weight : patternsMap.values()) {
            weights[index++] = weight;
        }
        return weights;
    }
}
