# GPU Monte Carlo
Monte carlo methods can be heavily optimized in parallel.
This method uses CUDA to estimate pi.
Due to the maximum int precision (no big int library used), it is hard to
have more than 6 valid decimals.

## Example
- Circle radius : 2 ^ 28
- Resolution (how many points drawn at random per thread) : 100'000.
- Blocks * threads : 100 * 100 = 100'000.
- Loops : Executed 10 times.
- Total samples : 40 billions.
- Execution time : Around 10 seconds on laptop GPU.

```
CPU : 314188
GPU
Number of samples : 40000 millions
Pi : 31415930647
```

## Notes
- The random number generator is made by hand using congruencies.

