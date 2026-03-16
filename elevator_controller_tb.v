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

#10 reset = 0;

// request floor 1
#10 request = 3'b010;

// request floor 2
#20 request = 3'b100;

// clear
#20 request = 3'b000;

#50 $stop;

end

endmodule