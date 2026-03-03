package ro.usv.rf.utils;

import java.util.ArrayList;
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
            Pattern p = new Pattern(patternSet[i]);
            if (patternsMap.containsKey(p))
            {
                patternsMap.put(p,patternsMap.get(p)+1);

            }
            else {
                patternsMap.put(p,1);
            }

        }
		return patternsMap;
	}

	public static double[] calculateWeightedAverages(Map<Pattern, Integer> patternsMap, int numberOfFeatures) {
		double[]  weightedAverages = new double[numberOfFeatures];
        int numberOfPatterns = 0;
		for (Map.Entry<Pattern,Integer> p : patternsMap.entrySet())
        {
            double[] pattern_key =  p.getKey().getPatternValues();
            numberOfPatterns += p.getValue();
            for ( int i=0; i<pattern_key.length;i++)
            {
                weightedAverages[i] += pattern_key[i] * p.getValue();
            }

        }
        for ( int i=0; i<numberOfFeatures;i++)
        {
            weightedAverages[i] = weightedAverages[i] / numberOfPatterns;
        }
		return weightedAverages;
	}
    public static double[] calculateDispertion(Map<Pattern, Integer> patternsMap, int numberOfFeatures) {
        double[]  weightedAverages = calculateWeightedAverages(patternsMap,numberOfFeatures);
        double[] dispersion = new double[numberOfFeatures];
        int numberOfPatterns = 0;
        for (Map.Entry<Pattern,Integer> p : patternsMap.entrySet())
        {
            double[] pattern_key =  p.getKey().getPatternValues();
            numberOfPatterns += p.getValue();
            for ( int i=0; i<pattern_key.length;i++)
            {
                dispersion[i] += (pattern_key[i] - weightedAverages[i]) * (pattern_key[i] - weightedAverages[i]) * p.getValue();
            }

        }
        for ( int i=0; i<numberOfFeatures;i++)
        {
            dispersion[i] = dispersion[i] / (numberOfPatterns-1);
        }
        return dispersion;
    }
}


