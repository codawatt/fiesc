using System;
using System.IO;
using System.Linq;
using System.Diagnostics;
using System.Collections;

namespace lab3
{
    class Program
    {
        static void Main(string[] args)
        {

            string inputPath = "in.txt";

            string[] lines = File.ReadAllLines(inputPath);
            File.WriteAllText("out.txt", "");
            int n = int.Parse(lines[0]);

            int[] numere = lines[1]
                .Split(' ')
                .Select(int.Parse)
                .ToArray();

            Console.WriteLine($"Numere: {n}");
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)) { outputFile.WriteLine($"Numere: {n}");}
            string msg = "";

            foreach (int num in numere)
            {
                msg += num.ToString() + ' ';
            }
            Console.WriteLine("Sir: " + msg);
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)) { outputFile.WriteLine("Sir: " + msg);}
            Stopwatch sw = Stopwatch.StartNew();
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)){outputFile.WriteLine($"Valoarea lipsa v1: {ValoareaLipsa_v1(numere,n)}");}
            sw.Stop();
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)){outputFile.WriteLine($"Timp de executie: {sw.ElapsedTicks} ticks");}
            sw = Stopwatch.StartNew();
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)){outputFile.WriteLine($"Valoarea lipsa v2: {ValoareaLipsa_v2(numere,n)}");}
            sw.Stop();
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)){outputFile.WriteLine($"Timp de executie: {sw.ElapsedTicks} ticks");}
            sw = Stopwatch.StartNew();
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)){outputFile.WriteLine($"Valoarea lipsa v3: {ValoareaLipsa_v3(numere,n)}");}
            sw.Stop();
            using (StreamWriter outputFile = new StreamWriter("out.txt", true)){outputFile.WriteLine($"Timp de executie: {sw.ElapsedTicks} ticks");}
            Console.WriteLine($"Valoarea lipsa : {ValoareaLipsa_v3(numere, n)}");
            
            Console.WriteLine(DeterminaMaxim(numere, 5));
            //GenerarePermutari(4);
        }

        static int ValoareaLipsa_v1(int[] A, int n){
            for (int v = 1; v <=n; v++){
                bool amGasit = false;
                for (int i = 0; i <=n-2; i++)
                {
                    int tmp = A[i];

                    if (A[i] == v){ 
                        amGasit = true;
                        break;
                    }
                }
                if (amGasit == false) 
                {
                    return v;
                }
            }
            return 0;
        }
        static int ValoareaLipsa_v2(int[] A, int n){

            int[] prezent = new int[n];
            for (int i = 0; i<= n-1;i++)
            {
                prezent[i] = 0;
            }
            for (int i = 0; i<= n-2;i++)
            {
                prezent[A[i]-1] = 1;
            }
            for (int i = 0; i<= n-1;i++)
            {
                if (prezent[i] == 0)
                {
                    return i + 1;
                }
            }
            return 0;
        }
        static int ValoareaLipsa_v3(int[] A, int n){

            int suma = 0;
            for (int i = 0; i <= n-2; i++){
                suma = suma + A[i];
            }
            return n* (n+1)/2 - suma;
        }
        static int DeterminaMaxim( int[] a, int n){
            int max = a[0];
            for ( int i = 0; i <= n-1;i++){
                if (max < a[i])
                {
                    max = a[i];
                }
            }
            return max;
        }

        //void GenerarePermutari(int n)
        //{
        //    int k = 0;
        //    Stack stiva = new Stack();
        //    stiva[k] = 0;

        //    bool as = false;
        //    while(k >= 0)
        //    {   
        //        do 
        //        {
        //            bool as = true;
        //            if (stiva[k] < n) {
        //                stiva[k] = stiva[k] + 1;
        //                ev = true;
        //                for( int i = 0; i <= k-1;i++)
        //                {
        //                    if (stiva[i] == stiva[k])
        //                    {
        //                        ev = false;
        //                    }
        //                }
        //                else as = false;
        //            }

        //        } while (as and !ev)
        //        if (as){
        //            if (k == n-1)
        //            {
        //                for (int i = 0; i <= n-1; i++)
        //                {
        //                    Console.WriteLine(stiva[i]);
        //                }
        //            }
        //            else{
        //                k = k + 1;
        //                stiva[k] = 0
        //            }
        //        }
        //        else k = k - 1;
        //    }

        //}
    }

}