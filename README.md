# Human-Reaction-Speed-Tester

[中文版](./README_CN.md)

## Project Overview

This project aims to develop a Human Reaction Speed Tester that evaluates participants' reaction times through a series of light and button interactions. The design received a high score of 98 in internal evaluations.

## Basic Functions

1. **Test Start**:

   - The user initiates the test by pressing the control switch (Ks).

2. **Signal Light Display**:

   - The system features 4 signal lights (L1-L4), which randomly display a combination between 0001 and 1111 during each test.
   - The combination changes automatically every two seconds.

3. **Timing Mechanism**:

   - The timer starts when the signal lights turn on.
   - If the button pressed by the user (K1-K4) corresponds to the current combination of lit signal lights, the timer stops.
   - If no button is pressed or the button is incorrect, the timer continues to run.

4. **Display**:

   - The timer output is shown on a 4-digit digital display, with two digits for seconds and two digits for decimal seconds.

5. **Test Cycle**:

   - At the start of each new test, the timer resets automatically when the signal light changes.
   - After completing ten tests, the system automatically ends the test and displays the cumulative total duration.

6. **Pass/Fail Criteria**:

   - If the total duration is less than 10 seconds, the test is considered passed, and the "PASS" indicator lights up.
   - Otherwise, the test fails, and the "FAIL" indicator lights up.

7. **Error Accumulation**:

   - Each incorrect button press is accumulated, and if the error count reaches 4 or more, the test is marked as failed regardless of timing.

8. **Result Display**:
   - After the test, the average reaction time of the ten tests is displayed, with dynamic timing information shown.

## Development Platform

- The project is developed using the EPM1270-V08 development board.
- ![image](https://github.com/user-attachments/assets/085b7bcb-b9e1-4138-ad98-f613eca90189)
- QuartusII9.1

## Module Structure and Overall Block Diagram

![image](https://github.com/user-attachments/assets/a421a835-f3a2-45b5-9ac3-671e9d6c47ba)
![image](https://github.com/user-attachments/assets/6c70e3de-bf85-4c05-a4f8-04c48d714717)


## Overall Scheme Description

1. **Clock Signal Processing**:

   - The pulse clock source is connected to the circuit, providing a 1kHz signal.
   - The frequency divider module (fdiv) divides it into 100Hz, 10Hz, 1Hz, 0.5Hz, 2Hz, and 0.1Hz signals for subsequent circuits.
   - The 0.5Hz clock is used for the pseudo-random number generator, which outputs a 4-bit random binary number to the indicator lights and the comparator.

2. **Signal Processing and Timing**:

   - The random number generator output is compared with external button signals in the comparator, with results sent to the latch.
   - The timer uses a 2Hz clock for timing, and a 0.5Hz clock for 2-second timing.
   - The timer and display circuit (dy_time) receive data from the latch to determine whether to continue timing, using a 100Hz clock for displaying seconds and decimal seconds.

3. **Display and Judgment**:
   - The dynamic signal refresh module (dy_gen) is used for dynamic digital display.
   - The dy_time module includes a test result statistics module, providing API interfaces for result judgment and display.
   - The wr_pa module displays pass or fail status, ensuring that when the dynamic refresh signal is input to 74244, both cannot be active simultaneously.

## Module Principles and Diagrams

- For more detail,please click following:

[English Version](./Design-EN.md)

[中文版](./Design-CN.md)
