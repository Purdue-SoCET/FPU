#include <stdio.h>

#include "svdpi.h"
#include "math.h"
// #include <stdbool.h>
// #include "Vtest__Dpi.h"
// #include "softfloat.h"

#include "dpi.h"

int isNaN(logic_t binary_float) {
    logic_t E = (binary_float >> FRACTION_WIDTH) & EXPONENT_MASK;
    logic_t F = binary_float & FRACTION_MASK;
    if ((E == EXPONENT_MASK) && (F != 0)) {
        return 1;
    }
    return 0;
}

int isInf(logic_t binary_float) {
    logic_t E = (binary_float >> FRACTION_WIDTH) & EXPONENT_MASK;
    logic_t F = binary_float & FRACTION_MASK;
    if ((E == EXPONENT_MASK) && (F == 0)) {
        return 1;
    }
    return 0;
}


// convert binary to float
double binary_to_float(logic_t binary_float) {
    int S = (binary_float >> (WIDTH - 1)) & 1;
    int E = (binary_float >> FRACTION_WIDTH) & EXPONENT_MASK;
    int F = binary_float & FRACTION_MASK;
    int bias = pow(2,EXPONENT_WIDTH-1)-1;
    double float_result;
    // printf("S:%d, E:%d, F:%d\n",S,E,F);
    // Special cases
    if (E == EXPONENT_MASK) {  // Checking for '1' in all exponent bits
        if (F != 0) return NAN;  // NaN
        return S ? -INFINITY : INFINITY;  // Infinity
    }
    // Denormalized numbers
    if (E == 0) {
        float_result = pow(-1, S) * pow(2.0, -(bias - 1)) * (F/(pow(2.0,FRACTION_WIDTH)));
    }
    // Normalized numbers
    else {
        float_result = pow(-1, S) * pow(2.0, E - bias) * (1+(F/(pow(2.0,FRACTION_WIDTH))));
    }

    return float_result;
}

// convert float to binary
logic_t float_to_binary(double float_output){
    int S;
    logic_t F;
    logic_t binary_output;
    logic_t final_binary_output;
    double normalized_num;
    int int_part;
    double frac_part;
    int biased_exponent;
    double temp;
    int subnorm_flag = 0;
    int bias = pow(2,EXPONENT_WIDTH-1)-1;

    //define the sign bit S
    if (float_output < 0) {
        S = 1;
    }
    else { 
        S = 0;
    }
    //Normalize the output
    normalized_num = float_output;
    biased_exponent = 0;

    // get fabs(normalized_num) to help calculating since we already get the Signed bit
    normalized_num = fabs(normalized_num);

    // CASE 1: if output >= 2.0, divided until it become (1.mantissa) and get the exponent
    while (normalized_num >= 2.0) {
        normalized_num /= 2.0;
        biased_exponent++;
    }
    // CASE 2: if output < 1.0, muliplied until it become (1.mantissa) and get the exponent
    //Subnormal num: if the biased_exponent is exceed the maximum number it can represent, just stop and stay (0.mantissa)
    while (normalized_num < 1.0 && biased_exponent > -(bias-1)) {
        normalized_num *= 2.0;
        biased_exponent--;
    }

    //Handle subnorms (if the number is too small to be represented with the biased exponent)
    //Set the subnorm_flag
    if(normalized_num < 1.0) {
        subnorm_flag = 1;
    }

    // convert mantissa into FRACTION_WIDTH bits binary
    F = 0;
    int_part = floor(normalized_num);
    frac_part = normalized_num-int_part;
    temp = frac_part;
    for (int i = (FRACTION_WIDTH-1); i >=0; i--) {
        temp *= 2.0;
        if (temp >= 1.0) {
            F |= (1 << i);
            temp -= 1.0;
        }
    }

    // Normalized number in the form: 1.mantissa x 2^biased_exponent
    // Bias is WIDTH-1 for half-precision
    biased_exponent = biased_exponent + bias;

    // Handle subnorms (if the number is too small to be represented with the biased exponent)
    if (subnorm_flag) {
        F = F >> (-biased_exponent + 1);
        biased_exponent = 0; 
        binary_output = (S << (EXPONENT_WIDTH + FRACTION_WIDTH)) | (biased_exponent << FRACTION_WIDTH) | F;
        final_binary_output = check_margin_err(float_output,binary_output);
        return final_binary_output;
    }

    binary_output = (S << (EXPONENT_WIDTH + FRACTION_WIDTH)) | (biased_exponent << FRACTION_WIDTH) | F;
    final_binary_output = check_margin_err(float_output,binary_output);

    return final_binary_output;
}

logic_t check_margin_err(double out, logic_t binary_output){
    logic_t binary_output_add1;
    double temp1;
    double temp2;
    binary_output_add1 = binary_output +1 ;
    temp1 = binary_to_float(binary_output);
    temp2 = binary_to_float(binary_output_add1);
    if ((fabs(out-temp1)) < (fabs(out-temp2))) {
        return binary_output;
    }
    else {
        return binary_output_add1;
    }
}

// compute expected output function
logic_t compute_expected_output(logic_t binary_float1, logic_t binary_float2){
    int sign_output;
    // logic [WIDTH-1:0]QNAN,sNaN,Inf,nInf,max_norm,mini_sub;
    double float_output;
    logic_t binary_output;
    double norm_bound;
    double subnorm_bound;

    norm_bound = binary_to_float(MAX_NORM);  //maximum normalize number
    subnorm_bound = binary_to_float(MINI_SUB); //smallest subnormal number

    // Handling NaN case
    // Any calculation involved NaN {exp = 5'b11111, mant != 0} => QNAN
    if (isNaN(binary_float1) || isNaN(binary_float2)) {
        return QNAN; 
    }
    
    // Handling Inf + (-Inf) case
    int sign1 = (binary_float1 >> (WIDTH - 1)) & 1;
    int sign2 = (binary_float2 >> (WIDTH - 1)) & 1;
    if ((sign1 != sign2) && (isInf(binary_float1) && isInf(binary_float2))) {
        return QNAN;  // Inf + (-Inf) -> QNAN
    }

    // add directly by converting binary to float
    float_output = binary_to_float(binary_float1) + binary_to_float(binary_float2);

    //calculate the signed bit of sum
    if(float_output < 0) {
        sign_output = 1;
    }
    else {
        sign_output = 0;
    }

    // Handling Inf case
    if (isInf(binary_float1) || isInf(binary_float2)) {
        return (sign_output << (WIDTH - 1)) | (EXPONENT_MASK << FRACTION_WIDTH);
    }

    // Handling Underflow case
    if((float_output < (subnorm_bound) && float_output > (-subnorm_bound))) {
        return (sign_output << (WIDTH - 1));    //underflow-> flush to 0
    }
    
    // Handling Overflow case
    if ((float_output > norm_bound) || (float_output < (-norm_bound))) {
        if(sign_output) { 
            return NINF; //Overflow-> -Inf
        }
        else { 
            return INF;  //Overflow-> Inf
        }
    }
    
    //convert float to binary
    binary_output = float_to_binary(float_output);

    return binary_output;

}