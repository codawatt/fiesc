#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <chrono>



int minimIterativ(const std::vector<int>& v) {
    int mn = v[0];
    for (int i = 1; i < (int)v.size(); i++) {
        if (v[i] < mn) mn = v[i];
    }
    return mn;
}


int minimRec(int st, int dr, const std::vector<int>& v) {
    if (st == dr) return v[st];
    int mid = (st + dr) / 2;
    int a = minimRec(st, mid, v);
    int b = minimRec(mid + 1, dr, v);
    return (a < b) ? a : b;
}

int main() {
    int dimensiuni[4] = {1000, 10000, 100000, 1000000};

    std::ofstream fout("comparatie_minim.txt");
    if (!fout) return 1;

    fout << "n timp_iterativ_ms timp_recursiv_ms\n";

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

        // masurare iterativ
        auto start1 = std::chrono::high_resolution_clock::now();
        int mn1 = minimIterativ(v);
        auto stop1 = std::chrono::high_resolution_clock::now();
        double tIter = std::chrono::duration<double, std::milli>(stop1 - start1).count();

        // masurare recursiv
        auto start2 = std::chrono::high_resolution_clock::now();
        int mn2 = minimRec(0, nDinFisier - 1, v);
        auto stop2 = std::chrono::high_resolution_clock::now();
        double tRec = std::chrono::duration<double, std::milli>(stop2 - start2).count();

        // evitam optimizari care ar elimina calculele
        if (mn1 != mn2) std::cout << "Eroare!\n";

        fout << nDinFisier << " " << tIter << " " << tRec << "\n";
    }

    fout.close();
    return 0;
}