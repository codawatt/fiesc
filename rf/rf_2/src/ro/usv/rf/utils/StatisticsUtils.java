package ro.usv.rf.utils;

import java.util.HashMap;
import java.util.Map;

public class StatisticsUtils {
	
	protected static double calculateFeatureAverage(double[] feature)
	{
		double average = 0.0;
		for (int i=0; i<feature.length; i++)
		{
			average += feature[i];
		}
		average = average/feature.length;
		return average;
	}
	
	protected static Map<Pattern, Integer> getPatternsMapFromInitialSet(double[][] patternSet) {
		Map<Pattern, Integer> patternsMap = new HashMap<Pattern, Integer>();
		for (int i=0; i<patternSet.length; i++)
        {
            
        }
		return patternsMap;
	}

	public static double[] calculateWeightedAverages(Map<Pattern, Integer> patternsMap, int numberOfFeatures) {
		double[]  weightedAverages = new double[numberOfFeatures];
		//enter code here
		return weightedAverages;
	}
}
