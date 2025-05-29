#  4-Way Traffic Light Controller (FPGA-Based)

This project implements a real-time **4-Way Traffic Light Controller** using **Verilog** and an **FPGA**. It simulates traffic signals at a four-way intersection using external LEDs connected on a breadboard.

##  Project Aim

To design and implement a 4-way traffic signal controller using a Finite State Machine (FSM) on an FPGA that mimics the behavior of a real-world intersection.

##  Overview

- Each of the 4 paths at the intersection has its own traffic light (Left, Right, Straight, Back).
- At any given time, only one path will have a **green** signal.
- The signals change cyclically to allow traffic flow from each direction in turn.

##  Project Approach

### 1. Finite State Machine (FSM)
- **States**:  
  - `S_LEFT`: Left path green  
  - `S_RIGHT`: Right path green  
  - `S_STRAIGHT`: Straight path green  
  - `S_BACK`: Back path green  
- Each state represents a direction where traffic is allowed to flow.

### 2. Clock Divider
- A clock divider module reduces the high-frequency system clock to generate **1-second intervals** for state transitions.

### 3. LED Setup
- External LEDs represent traffic signals.
- Each path uses **3 LEDs** (Red, Yellow, Green).
- The active signal for each path is shown via LED status.

##  State Transition Logic

1. Start at `S_LEFT` — Left path green.  
2. After a fixed time, move to `S_RIGHT`.  
3. Then to `S_STRAIGHT`.  
4. Then to `S_BACK`.  
5. Cycle repeats continuously.  
6. **Reset button** re-initializes the state machine to `S_LEFT`.
