`timescale 1ns / 1ps

module elevator_controller(
    input clk,
    input reset,
    input [2:0] request,      // floor requests (3 floors)
    output reg [1:0] floor,   // current floor (0-2)
    output reg door_open
);

// STATES
parameter IDLE = 2'b00,
          MOVE_UP = 2'b01,
          MOVE_DOWN = 2'b10,
          OPEN_DOOR = 2'b11;

reg [1:0] state, next_state;

// door timer
reg [2:0] door_timer;  // keeps door open for few cycles

// STATE REGISTER + FLOOR INIT

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        state <= IDLE;
        floor <= 0;         // start from ground floor
        door_timer <= 0;
    end
    else begin
        state <= next_state;
    end
end

// NEXT STATE LOGIC
always @(*)
begin
    case(state)

        IDLE: begin
            if(request[floor])
                next_state = OPEN_DOOR;

            else if( (request > (1 << floor)) && (floor < 2) )
                next_state = MOVE_UP;

            else if( (request < (1 << floor)) && (request != 0) && (floor > 0) )
                next_state = MOVE_DOWN;

            else
                next_state = IDLE;
        end

        MOVE_UP: begin
            if(request[floor+1])
                next_state = OPEN_DOOR;
            else
                next_state = IDLE;
        end

        MOVE_DOWN: begin
            if(request[floor-1])
                next_state = OPEN_DOOR;
            else
                next_state = IDLE;
        end

        OPEN_DOOR: begin
            if(door_timer == 3)
                next_state = IDLE;
            else
                next_state = OPEN_DOOR;
        end

        default:
            next_state = IDLE;

    endcase
end

// OUTPUT + FLOOR UPDATE
always @(posedge clk)
begin
    case(state)

        IDLE: begin
            door_open <= 0;
            door_timer <= 0;
        end

        MOVE_UP: begin
            door_open <= 0;
            if(floor < 2)
                floor <= floor + 1;
        end

        MOVE_DOWN: begin
            door_open <= 0;
            if(floor > 0)
                floor <= floor - 1;
        end

        OPEN_DOOR: begin
            door_open <= 1;
            door_timer <= door_timer + 1;
        end

    endcase
end

endmodule
