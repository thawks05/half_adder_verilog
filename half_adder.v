//A simple half adder, written in Verilog, to build understanding
//of combinational logic, inputs, and outputs. 
module half_adder (a, b, cout, sum);
    input a, b;
    output sum, cout;

    xor sum1 (sum, a, b);
    and carry1 (cout, a, b);
endmodule