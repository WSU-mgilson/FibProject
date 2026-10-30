# CEG 3310/5310 – Computer Organization

## Project 5 – Recursion in Assembly

## Learning Objectives

- Learn how to implement recursive subroutines in assembly.

## Overview

You will be implementing recursive subroutines in assembly. A common exercise in recursive programming is displaying the Fibonacci Sequence.

The Fibonacci sequence is defined as:

```
F(n) = F(n-1) + F(n-2)
```

where `F(0) = 0` and `F(1) = 1`.

For example, the first 7 numbers in the Fibonacci Sequence are:

| F(0) | F(1) | F(2) | F(3) | F(4) | F(5) | F(6) |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|  0   |  1   |  1   |  2   |  3   |  5   |  8   |

Notice how `F(2) = F(1) + F(0) = 0 + 1 = 1` and how `F(6) = F(5) + F(4) = 5 + 3 = 8`.

## The Program

You will have to implement a recursive subroutine that returns the desired number in the Fibonacci Sequence. An example output of your completed lab should look like the following:

```
Please enter a number n: 9
F(9) = 34
```

Another example:

```
Please enter a number n: 6
F(6) = 8
```

This can be accomplished by implementing a recursive function with a properly implemented general case and base case:

- **General case:** `F(n) = F(n-1) + F(n-2)`
- **Base cases:** `F(0) = 0` and `F(1) = 1`

Notice that in order to calculate `F(n)`, you must call `F(n-1)` and `F(n-2)`. This will be implemented using recursion.

### Example Call Sequence (n = 3)

For a value of `n = 3`, your subroutines will call each other in this manner:

1. `fibonacci(3)` calls `fibonacci(2)` + `fibonacci(1)`
2. `fibonacci(2)` calls `fibonacci(1)` + `fibonacci(0)`
3. `fibonacci(1)` returns `1` to `fibonacci(2)` and `fibonacci(3)`
4. `fibonacci(0)` returns `0` to `fibonacci(2)`
5. `fibonacci(2)` returns `1 + 0 = 1` to `fibonacci(3)`
6. `fibonacci(3)` returns `1 + 1 = 2` to `main()`
7. `main()` displays `"F(3) = 2"` to the user

### Reference C Implementation

```c
int fibonacci(int n) {
    if (n <= 1) {
        return n;
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}
```

## Implementation

- Write a **runtime stack spreadsheet** to keep track of the runtime stack before programming. You can write a runtime stack for `fibonacci(4)` or so. Any higher values of `n` will make a very confusing runtime stack.
- Implement the **`main` function** in assembly.
- Implement the **`fibonacci` function** as an LC-3 assembly subroutine. This function must be recursive; that is, it calls itself until the base case is reached.
- Maintain a **proper runtime stack**. This runtime stack should allow for multiple `fibonacci` subroutine calls, passing inputs to each function call, and returning outputs properly without losing or corrupting any data.
