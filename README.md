# Elevator Controller (Verilog)

**Overview:**  
This project implements a simple multi-floor elevator controller using Verilog.  
The system is designed using a Finite State Machine (FSM) to control the elevator’s movement between floors and manage floor requests.

The aim of this project was to understand how sequential logic and FSMs can be used to model a real-world control system like an elevator.

**Features:**

- Handles floor requests from different floors  
- Controls elevator movement (up and down)  
- Implements door open and close logic  
- Designed using a Finite State Machine (FSM)  
- Includes a simulation testbench to verify functionality  

**Files:**

- **elevator_controller.v** – Main Verilog module that implements the elevator control logic  
- **elevator_controller_tb.v** – Testbench used to simulate and verify the design  

**Concepts Used:**

- Finite State Machine (FSM)  
- Sequential Logic  
- Verilog HDL  
- Digital System Design  

**How it Works:**

The elevator controller is implemented using a finite state machine.  
Depending on the floor request inputs, the controller decides whether the elevator should move up, move down, or stay at the current floor.

The system transitions between states such as **idle**, **moving up**, **moving down**, and **door control** based on the input signals.

The testbench simulates different floor requests to check whether the elevator controller responds correctly.

**Future Improvements:**

- Support for additional floors  
- Priority handling for multiple floor requests  
- Adding timing control for door operations  
