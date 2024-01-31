#include <iostream>
#include "SumClass.h"

int main() {
    SumClass sum_object;

    std::cout << "Initial sum_value: " << sum_object.getSum() << std::endl;

    sum_object.add(5, 3);
    std::cout << "After adding 5 and 3: " << sum_object.getSum() << std::endl;

    sum_object.add(10, -2);
    std::cout << "After adding 10 and -2: " << sum_object.getSum() << std::endl;

    return 0;
}