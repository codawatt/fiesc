package ro.usv.rf.utils;
/*
 * Autor:PSG, feb. 2021
 */
public class DistanceUtils {
    public static double distEuclid ( double x[], double y[] ) {
        if(x.length != y.length) throw new SpatiiDeDimensiuniDiferite(
                "("+x.length+", "+y.length+")");

        double d = 0;
        for(int j=0; j< x.length; j++)
            d += (x[j]-y[j])* (x[j]-y[j]);

        return Math.sqrt(d);
    }
    public static double distCheb ( double x[], double y[] ) {
        if(x.length != y.length) throw new SpatiiDeDimensiuniDiferite(
                "("+x.length+", "+y.length+")");

        double d = 0;
        for(int j=0; j< x.length; j++)
            d = Math.max(d, Math.abs(x[j]-y[j]));
        return d;
    }
    public static double cityBlock ( double x[], double y[] ) {
        if(x.length != y.length) throw new SpatiiDeDimensiuniDiferite(
                "("+x.length+", "+y.length+")");

        double d = 0;
        for(int j=0; j< x.length; j++)
            d += Math.abs(x[j] - y[j]);
        return d;
    }

    public static void main(String[] args) {
        double[] x = new double[] {1, 5},
                y = new double[] {5, 2},
                z = new double[] {3, 5}; //necoliniar cu x si y

        System.out.println("d(x,x) ="+distEuclid(x,x));
        System.out.println("d(x,y) ="+distEuclid(x,y));
        System.out.println("d(y,x) ="+distEuclid(y,x));
        System.out.println("d(x,z) + d(z,y)=" +

                (distEuclid(x,z) + distEuclid(z,y)) );

        System.out.println("z1 este coliniar cu x si y");
        double [] z1 = new double[] {3, 3.5};
        System.out.println("d(x,z1) + d(z1,y)=" +

                (distEuclid(x,z1) + distEuclid(z1,y)) );

        double [] v = new double[] {0};
        System.out.println("d(x,v) ="+distEuclid(x,v));
    }
}
class SpatiiDeDimensiuniDiferite extends RuntimeException{
    public SpatiiDeDimensiuniDiferite(String message) {
        super(message);
    }
}