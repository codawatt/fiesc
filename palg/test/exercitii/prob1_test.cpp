#include <fstream>
#include <vector>
#include <iostream>

int cycle_len(int n, std::vector<int>& memo) {
    if (n == 1) return 1;

    if (n < (int)memo.size() && memo[n] != 0) return memo[n];

    long long next;
    if (n % 2 == 1) {
        next = 3LL * n + 1;
    } else {
        next = n / 2;
    }

    int ans;
    if (next < (int)memo.size()) {
        ans = 1 + cycle_len((int)next, memo);
    } else {
        // next may exceed memo range; compute without memo for that part
        ans = 1;
        long long x = next;
        while (x != 1 && x >= (long long)memo.size()) {
            if (x % 2 == 1) x = 3 * x + 1;
            else x = x / 2;
            ans++;
        }
        if (x == 1) ans += 0; // already counted steps to reach 1
        else ans += cycle_len((int)x, memo);
    }

    if (n < (int)memo.size()) memo[n] = ans;
    return ans;
}

int main() {
    std::ifstream in("prob1_test.txt");
    if (!in) return 1;

    std::ofstream out("out_test.txt");   // overwrite by default
    if (!out) return 1;

    int i, j;

    // Memoize for values up to a practical limit (inputs < 10000; sequences can go higher)
    std::vector<int> memo(1000000, 0);
    memo[1] = 1;

    while (in >> i >> j) {
        int a = i, b = j;
        if (a > b) {
            int t = a; a = b; b = t;
        }

        int best = 0;
        for (int n = a; n <= b; n++) {
            int len = cycle_len(n, memo);
            if (len > best) best = len;
        }

        out << i << ' ' << j << ' ' << best << std::endl;
    }

    return 0;
}