#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <chrono>

int main() {
    int dimensiuni[4] = {1000, 10000, 100000, 1000000};
    std::string distributie = "crescatoare"; // conform generarii anterioare (rand()%1000)

    std::ofstream fout("timpi.txt");
    if (!fout) return 1;

    fout << "n distributie timp_ms\n";

    for (int d = 0; d < 4; d++) {
        int n = dimensiuni[d];
        std::string numeFisier = "date_" + std::to_string(n) + ".txt";

        std::ifstream fin(numeFisier);
        if (!fin) return 1;

        int nDinFisier;
        fin >> nDinFisier;

        std::vector<int> v(nDinFisier);
        for (int i = 0; i < nDinFisier; i++) fin >> v[i];
        fin.close();

        auto start = std::chrono::high_resolution_clock::now();

        long long suma = 0;
        for (int i = 0; i < nDinFisier; i++) suma += v[i];

        auto stop = std::chrono::high_resolution_clock::now();
        double timp_ms = std::chrono::duration<double, std::milli>(stop - start).count();

        fout << nDinFisier << " " << distributie << " " << timp_ms << "\n";
    }

    fout.close();
    return 0;
}