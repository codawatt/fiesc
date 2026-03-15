#include <iostream>
#include <fstream>
#include <vector>


int main() {

    int dimensiuni[4] = {1000, 10000, 100000, 1000000};

    for (int d = 0; d < 4; d++) {
        int n = dimensiuni[d];

        std::vector<int> v(n);

        for (int i = 0; i < n; i++) {
            v[i] = i + 1;
        }


        std::string numeFisier = "date_" + std::to_string(n) + ".txt";

        std::ofstream out(numeFisier);
        if (!out) return 1;

        out << n << "\n";
        for (int i = 0; i < n; i++) {
            out << v[i] << " ";
        }

        out.close();
    }

    return 0;
}