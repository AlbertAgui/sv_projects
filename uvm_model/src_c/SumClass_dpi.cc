#include "SumClass.h"
#include "svdpi.h"

static SumClass sum_object;

extern "C" bool sum_object_add(int a, int b) {
    return sum_object.add(a, b);
}

extern "C" int sum_object_getSum() {
    return sum_object.getSum();
}