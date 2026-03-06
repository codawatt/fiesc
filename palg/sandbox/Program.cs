using System;
using System.IO;
using System.Collections.Generic;
using System.Diagnostics;

namespace lab2
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] sizes = { 1000, 10000, 100000, 1000000 };

            string inputFolder = "input_files";
            string outputFolder = "output_files";

            Directory.CreateDirectory(inputFolder);
            Directory.CreateDirectory(outputFolder);

            // 1. Generate files
            for (int i = 0; i < sizes.Length; i++)
            {
                GenerateFile(inputFolder, sizes[i]);
            }

            // 2, 3, 4. Read files, insert into structures, write back, print times
            for (int i = 0; i < sizes.Length; i++)
            {
                int n = sizes[i];
                string inputFile = Path.Combine(inputFolder, "numbers_" + n + ".txt");

                Console.WriteLine("========================================");
                Console.WriteLine("File with " + n + " elements");
                Console.WriteLine("========================================");

                TestArray(inputFile, outputFolder, n);
                TestList(inputFile, outputFolder, n);
                TestQueue(inputFile, outputFolder, n);
                TestStack(inputFile, outputFolder, n);

                Console.WriteLine();
            }
        }

        static void GenerateFile(string folder, int n)
        {
            string fileName = Path.Combine(folder, "numbers_" + n + ".txt");

            using (StreamWriter writer = new StreamWriter(fileName))
            {
                for (int i = 1; i <= n; i++)
                {
                    writer.WriteLine(i);
                }
            }
        }

        static void TestArray(string inputFile, string outputFolder, int n)
        {
            Stopwatch stopwatch = new Stopwatch();

            int[] array = new int[n];

            stopwatch.Start();

            using (StreamReader reader = new StreamReader(inputFile))
            {
                string line;
                int index = 0;

                while ((line = reader.ReadLine()) != null)
                {
                    array[index] = int.Parse(line);
                    index++;
                }
            }

            stopwatch.Stop();
            long readTime = stopwatch.ElapsedMilliseconds;

            stopwatch.Reset();
            stopwatch.Start();

            string outputFile = Path.Combine(outputFolder, "array_" + n + ".txt");

            using (StreamWriter writer = new StreamWriter(outputFile))
            {
                for (int i = 0; i < array.Length; i++)
                {
                    writer.WriteLine(array[i]);
                }
            }

            stopwatch.Stop();
            long writeTime = stopwatch.ElapsedMilliseconds;

            Console.WriteLine("Array");
            Console.WriteLine("Read time: " + readTime + " ms");
            Console.WriteLine("Write time: " + writeTime + " ms");
            Console.WriteLine();
        }

        static void TestList(string inputFile, string outputFolder, int n)
        {
            Stopwatch stopwatch = new Stopwatch();

            List<int> list = new List<int>();

            stopwatch.Start();

            using (StreamReader reader = new StreamReader(inputFile))
            {
                string line;

                while ((line = reader.ReadLine()) != null)
                {
                    list.Add(int.Parse(line));
                }
            }

            stopwatch.Stop();
            long readTime = stopwatch.ElapsedMilliseconds;

            stopwatch.Reset();
            stopwatch.Start();

            string outputFile = Path.Combine(outputFolder, "list_" + n + ".txt");

            using (StreamWriter writer = new StreamWriter(outputFile))
            {
                for (int i = 0; i < list.Count; i++)
                {
                    writer.WriteLine(list[i]);
                }
            }

            stopwatch.Stop();
            long writeTime = stopwatch.ElapsedMilliseconds;

            Console.WriteLine("List");
            Console.WriteLine("Read time: " + readTime + " ms");
            Console.WriteLine("Write time: " + writeTime + " ms");
            Console.WriteLine();
        }

        static void TestQueue(string inputFile, string outputFolder, int n)
        {
            Stopwatch stopwatch = new Stopwatch();

            Queue<int> queue = new Queue<int>();

            stopwatch.Start();

            using (StreamReader reader = new StreamReader(inputFile))
            {
                string line;

                while ((line = reader.ReadLine()) != null)
                {
                    queue.Enqueue(int.Parse(line));
                }
            }

            stopwatch.Stop();
            long readTime = stopwatch.ElapsedMilliseconds;

            stopwatch.Reset();
            stopwatch.Start();

            string outputFile = Path.Combine(outputFolder, "queue_" + n + ".txt");

            using (StreamWriter writer = new StreamWriter(outputFile))
            {
                while (queue.Count > 0)
                {
                    writer.WriteLine(queue.Dequeue());
                }
            }

            stopwatch.Stop();
            long writeTime = stopwatch.ElapsedMilliseconds;

            Console.WriteLine("Queue");
            Console.WriteLine("Read time: " + readTime + " ms");
            Console.WriteLine("Write time: " + writeTime + " ms");
            Console.WriteLine();
        }

        static void TestStack(string inputFile, string outputFolder, int n)
        {
            Stopwatch stopwatch = new Stopwatch();

            Stack<int> stack = new Stack<int>();

            stopwatch.Start();

            using (StreamReader reader = new StreamReader(inputFile))
            {
                string line;

                while ((line = reader.ReadLine()) != null)
                {
                    stack.Push(int.Parse(line));
                }
            }

            stopwatch.Stop();
            long readTime = stopwatch.ElapsedMilliseconds;

            stopwatch.Reset();
            stopwatch.Start();

            string outputFile = Path.Combine(outputFolder, "stack_" + n + ".txt");

            using (StreamWriter writer = new StreamWriter(outputFile))
            {
                while (stack.Count > 0)
                {
                    writer.WriteLine(stack.Pop());
                }
            }

            stopwatch.Stop();
            long writeTime = stopwatch.ElapsedMilliseconds;

            Console.WriteLine("Stack");
            Console.WriteLine("Read time: " + readTime + " ms");
            Console.WriteLine("Write time: " + writeTime + " ms");
            Console.WriteLine();
        }
    }
}