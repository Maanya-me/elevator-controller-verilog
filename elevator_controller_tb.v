`timescale 1ns / 1ps

module elevator_controller_tb;

reg clk;
reg reset;
reg [2:0] request;

wire [1:0] floor;
wire door_open;

elevator_controller uut (
    .clk(clk),
    .reset(reset),
    .request(request),
    .floor(floor),
    .door_open(door_open)
);

// clock
always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;
    request = 3'b000;

    // Test Case 1
    #10 reset = 0;

    // Test Case 2
    #10 request = 3'b010;

    // Test Case 3
    #20 request = 3'b100;

    // Test Case 4
    #20 request = 3'b000;

    // Test Case 5
    #20 request = 3'b101;

    // Test Case 6
    #20 request = (1 << floor);

    #50 $stop;

end

endmodule
