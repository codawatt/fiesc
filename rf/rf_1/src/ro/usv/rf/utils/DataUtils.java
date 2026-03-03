package ro.usv.rf.utils;

public class DataUtils {
        public static void printMatrix(double[][] x){
            for(double[] lin: x){

                for(double xcrt: lin)
                    System.out.print(xcrt+"\t");
                System.out.println();
            }
        }

    public static double[][] normalizeLearningSet(
            double[][] patternSet)
    {
        double[][] normalizedPatternSet = new double[patternSet.length][patternSet[0].length];

        double max[]= new double[patternSet[0].length];
        double min[]= new double[patternSet[0].length];

        for (int j = 0; j < patternSet[0].length; j++) {
            max[j] = patternSet[0][j];
            min[j] = patternSet[0][j];
            for (int i = 0; i < patternSet.length ; i++) {
                if(max[j]< patternSet[i][j]) max[j] = patternSet[i][j];

                if(min[j] > patternSet[i][j]) min[j] = patternSet[i][j];

            }
        }
        for (int i = 0; i < patternSet.length; i++) {
            for (int j = 0; j < patternSet[0].length; j++) {
                normalizedPatternSet[i][j] = (patternSet[i][j] - min[j] ) / ( max[j] - min[j]);
            }
        }
        return normalizedPatternSet;
    }
}