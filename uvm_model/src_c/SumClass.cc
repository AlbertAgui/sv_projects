#include "SumClass.h"

    SumClass::SumClass() {
        sum_value = 0;
    }

    bool SumClass::add(int a, int b) {
        sum_value += (a + b);
        return true;
    }

    int SumClass::getSum() {
        return sum_value;
    }

