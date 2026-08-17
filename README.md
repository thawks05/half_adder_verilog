# Half Adder in Verilog

A gate-level half adder built in Verilog and verified in simulation with Icarus Verilog.

## Overview

A half adder adds two single bits, `a` and `b`, and produces two outputs: a sum bit and a carry bit. It is the simplest building block of binary addition. It is called a "half" adder because it can produce a carry out but cannot accept a carry in from a previous stage.

## Reason

I am learning Verilog, and am curious as to how testbenches and combinational logic works. This program uses the lowest abstraction layer of Verilog, written at the gate level. This was simple and introductory on my journey to hardware design in my career. 

## Specification

**Inputs**

| Signal | Width | Description |
|--------|-------|-------------|
| `a`    | 1 bit | First input bit |
| `b`    | 1 bit | Second input bit |

**Outputs**

| Signal | Width | Description |
|--------|-------|-------------|
| `sum`  | 1 bit | Result bit (`a XOR b`) |
| `cout` | 1 bit | Carry out (`a AND b`) |

## Truth table

| a | b | cout | sum |
|---|---|------|-----|
| 0 | 0 | 0    | 0   |
| 0 | 1 | 0    | 1   |
| 1 | 0 | 0    | 1   |
| 1 | 1 | 1    | 0   |

## Boolean logic

The two output columns each reduce to a single gate:

- `sum = a ^ b` (XOR): high only when the inputs differ
- `cout = a & b` (AND): high only when both inputs are 1

## Design

`half_adder.v`

```verilog
module half_adder (a, b, cout, sum);
    input a, b;
    output sum, cout;

    xor sum1 (sum, a, b);
    and carry1 (cout, a, b);
endmodule
```

This is a structural (gate-level) description: two primitive gates are instantiated and wired directly to the ports. In each gate instantiation the output is listed first, followed by the inputs.

## Testbench

`half_adder_tb.v`

```verilog
`timescale 1ns/1ps

module half_adder_tb;
    reg a, b;
    wire sum, cout;

    half_adder dut (
        .a(a),
        .b(b),
        .cout(cout),
        .sum(sum)
    );

    initial begin
        $display("a + b | carryout, sum");
        $display("--------------");

        a = 0; b = 0; #10;
        $display("%b + %b |    %b     %b", a, b, cout, sum);

        a = 0; b = 1; #10;
        $display("%b + %b |    %b     %b", a, b, cout, sum);

        a = 1; b = 0; #10;
        $display("%b + %b |    %b     %b", a, b, cout, sum);

        a = 1; b = 1; #10;
        $display("%b + %b |    %b     %b", a, b, cout, sum);

        $finish;
    end
endmodule
```

The testbench drives the two inputs through all four combinations, waits 10 ns for the outputs to settle after each, and prints the results.

## Build and run

Requires Icarus Verilog. On macOS: `brew install icarus-verilog`.

```bash
iverilog -o ha_test half_adder.v half_adder_tb.v
vvp ha_test
```

The first command compiles the design and testbench together into a simulation named `ha_test`. The second runs it.

## Simulation output

```
a + b | carryout, sum
--------------
0 + 0 |    0     0
0 + 1 |    0     1
1 + 0 |    0     1
1 + 1 |    1     0
```

All four rows match the truth table, so the design is verified.

## Notes and limitations

The half adder has no carry in, so it can only be used for the lowest bit position of a multi-bit adder. Every higher position must accept a carry from the stage below it, which requires a full adder (three inputs: `a`, `b`, and `cin`). Chaining one half adder with a series of full adders produces a ripple-carry adder that can add numbers of any width.

## Files

| File | Description |
|------|-------------|
| `half_adder.v` | Gate-level half adder design |
| `half_adder_tb.v` | Testbench |
| `.gitignore` | Excludes the compiled `ha_test` build artifact |
