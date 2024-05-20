#include <iostream>

namespace {
    void print(auto && obj) { std::cout << static_cast<decltype(obj)>(obj) << '\n'; }
}

int main() { print("Hello, world!"); }
