#ifndef DPI_H
#define DPI_H

#include <stdint.h>

// Define the width here
#define WIDTH 16

// Choose the appropriate type based on WIDTH
#if WIDTH == 16
    typedef uint16_t logic_t;
    #define EXPONENT_WIDTH 5  // Adjust this value for 16-bit
#elif WIDTH == 32
    typedef uint32_t logic_t;
    #define EXPONENT_WIDTH 8  // Adjust this value for 32-bit
#elif WIDTH == 64
    typedef uint64_t logic_t;
    #define EXPONENT_WIDTH 11 // Adjust this value for 64-bit
#else
    #error "Unsupported WIDTH"
#endif

#define FRACTION_WIDTH (WIDTH - EXPONENT_WIDTH - 1)
#define EXPONENT_MASK ((1U << EXPONENT_WIDTH) - 1)
#define FRACTION_MASK ((1ULL << FRACTION_WIDTH) - 1)

// Constants for special values like INF, NINF, QNAN
const logic_t INF = (EXPONENT_MASK << (FRACTION_WIDTH));
const logic_t NINF = (1U << (WIDTH - 1)) | (EXPONENT_MASK << (FRACTION_WIDTH));
const logic_t QNAN = (1U << (WIDTH - 1)) | (EXPONENT_MASK << (FRACTION_WIDTH)) | (FRACTION_MASK);
const logic_t SNAN = (1U << (WIDTH - 1)) | (EXPONENT_MASK << (FRACTION_WIDTH)) | (FRACTION_MASK - (1U << (FRACTION_WIDTH - 1)));
const logic_t MAX_NORM = ((EXPONENT_MASK << FRACTION_WIDTH) | FRACTION_MASK) - (1U << (FRACTION_WIDTH));
const logic_t MINI_SUB = 1U;

// Macro for reinterpretation
#define REINTERPRET(x, to) \
    (*(to *)(&(x)))

extern int isNaN(logic_t binary);
extern int isInf(logic_t binary);
extern double binary_to_float(logic_t binary_float);
extern logic_t check_margin_err(double out, logic_t binary_output);
extern logic_t float_to_binary(double float_output);
extern logic_t compute_expected_output(logic_t binary_float1, logic_t binary_float2);


#endif // DPI_H