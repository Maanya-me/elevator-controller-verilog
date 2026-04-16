`timescale 1ns / 1ps

module elevator_controller(
    input clk,
    input reset,
    input [2:0] request,      // floor buttons
    output reg [1:0] floor,   // current floor
    output reg door_open
);

parameter IDLE = 2'b00,
          MOVE_UP = 2'b01,
          MOVE_DOWN = 2'b10,
          OPEN_DOOR = 2'b11;

reg [1:0] state, next_state;


// State register
always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= IDLE;
    else
        state <= next_state;
end


// Next state logic
always @(*)
begin
    case(state)

        IDLE: begin
            if(request[floor])
                next_state = OPEN_DOOR;
            else if(request > (1 << floor))
                next_state = MOVE_UP;
            else if(request < (1 << floor) && request != 0)
                next_state = MOVE_DOWN;
            else
                next_state = IDLE;
        end

        MOVE_UP:
            next_state = IDLE;

        MOVE_DOWN:
            next_state = IDLE;

        OPEN_DOOR:
            next_state = IDLE;

        default:
            next_state = IDLE;

    endcase
end


// Output logic
always @(posedge clk)
begin
    case(state)

        IDLE:
            door_open <= 0;

        MOVE_UP: begin
            floor <= floor + 1;
            door_open <= 0;
        end

        MOVE_DOWN: begin
            floor <= floor - 1;
            door_open <= 0;
        end

        OPEN_DOOR:
            door_open <= 1;

    endcase
end

endmodule
