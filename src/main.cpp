#include <iostream>
#include <string_view>

namespace {
    void print(auto && obj) { std::cout << static_cast<decltype(obj)>(obj) << '\n'; }
}

int main()
{
    using namespace std::string_view_literals;
    print("Hello, world!"sv);
}
