#include <fstream>
#include <vector>
#include <iostream>

int main() {
    std::ifstream in("input.txt");
    if (!in) return 1;

    int n;
    in >> n;

    std::vector<int> a(n);
    for (int i = 0; i < n; ++i)
        in >> a[i];

    // example: print to verify
    for (int x : a)
        std::cout << x << ' ';
	
	return 1;
}