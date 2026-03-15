#include <fstream>
#include <vector>
#include <iostream>


int main() {
    std::ifstream in("prob1.txt");
    if (!in) return 1;

    std::ofstream out("out.txt");  
    if (!out) return 1;

    long long n;
    in >> n; 

	std::vector<long long> a;
	a.push_back(n);

	while (n!=1) {

		if (n%2 == 1) {
			n = 3 * n + 1;		
		}
		else {
			n = n / 2;
		}

		a.push_back(n);	
	}

	out << a.size() << std::endl;
    for (long long x : a){

        out << x << ' ';
	}
	return 0;
}