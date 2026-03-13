package ro.usv.rf.labs.lab2;

import ro.usv.rf.utils.FileUtils;
import ro.usv.rf.utils.StatisticsUtils;
import ro.usv.rf.utils.Pattern;
import java.util.Arrays;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Map;

public class MainClass {

	public static void main(String[] args) {
		double[][] patternSet = FileUtils.readLearningSetFromFile("in_lab2.txt");
		int numberOfPatterns = patternSet.length; // randuri
		int numberOfFeatures = patternSet[0].length; // coloane
        Dictionary<double[],Integer> weightedMap = new Hashtable<double[], Integer>();

		for (int j=0; j<numberOfFeatures; j++)
		{
			double[] feature = new double[numberOfPatterns];
			for (int i=0; i<numberOfPatterns; i++)
			{
				feature[i] = patternSet[i][j];

			}
			System.out.println("Feature average is:" + StatisticsUtils.calculateFeatureAverage(feature));
		}

		Map<Pattern, Integer> patternsMap = StatisticsUtils.getPatternsMapFromInitialSet(patternSet);

        for (Map.Entry<Pattern,Integer> p : patternsMap.entrySet())
        {
            System.out.println(p);
        }


		double[] weightedAverages = StatisticsUtils.calculateWeightedAverages(patternsMap, numberOfFeatures);
        System.out.println(Arrays.toString(weightedAverages));
        double[] dispertion = StatisticsUtils.calculateDispertion(patternsMap, numberOfFeatures);
        System.out.println(Arrays.toString(dispertion));

	}


}
