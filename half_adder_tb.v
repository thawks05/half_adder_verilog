module half_adder_tb;
    //Inputs - declared reg because an initial block drives them
    reg a, b;
    //Outputs - declared wire because driver adds them
    wire sum, cout;

    //Instantiate the design under test (DUT)
    half_adder dut(
        .a(a),
        .b(b),
        .cout(cout),
        .sum(sum)
    );

    initial begin
        $display("a + b | carryout, sum");
        $display("--------------");

        //A is our initial bit, B is out other bit,
        //#10 sets simulation time unit of 10 nanoseconds
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