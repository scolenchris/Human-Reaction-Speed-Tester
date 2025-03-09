# Explanation of Unit Circuit Design Principles and Simulation Waveforms

## 1.1Frequency Divider (fdiv) Design Principles and Simulation Waveforms

**Figure 1.1 Final Circuit Diagram of the Frequency Divider**

![image](https://github.com/user-attachments/assets/7dc192c0-e7ad-4824-b0ad-6d9d490dcbbf)

The objective of the frequency divider is to generate clock signals of 100 Hz, 10 Hz, 1 Hz, 0.5 Hz, 2 Hz, and 0.1 Hz. Initially, the 74160 counter was employed for base conversion, where the overflow signal was used as the clock signal for the subsequent 74160 counter to achieve a divide-by-ten function. However, the first issue was identified during this process.

**Figure 1.2 Original Frequency Divider Circuit Diagram**

![image](https://github.com/user-attachments/assets/10d6591b-ee7f-4ae1-b480-241d458d6bb1)

**Figure 1.3 Simulation Waveform of the Original Frequency Divider Circuit**

![image](https://github.com/user-attachments/assets/36477ff6-5f82-4509-b069-5de482aaa975)

When designed as per the above diagram, the timing simulation revealed that clk100 was actually clk50, achieving a divide-by-twenty function. The issue was traced back to the clock signal input to the first 74160 counter. Since a complete pulse was required for each count, it took 10 counts to produce a rising edge, and considering the fall time, it effectively resulted in 20 counts, which deviated from the expected outcome. This was subsequently rectified by using the 7490 counter to achieve a divide-by-five, which in practice resulted in a divide-by-ten function.

The second issue pertained to clk1, which was initially set to clk100 for convenience. To compare the performance of the 7490 and 74160 counters, it was observed that the timing waveform at the clk1 position exhibited incomplete waveforms, although the frequency was correct at 100 Hz, aligning with the design expectations. To address this, the incorporation of a JK flip-flop was considered to rectify the waveform.

**Figure 1.4 Revised Frequency Divider Circuit Diagram**

![image](https://github.com/user-attachments/assets/6415475c-986b-41a3-bf48-9da003c18a9e)

**Figure 1.5 Simulation Waveform of the Revised Frequency Divider Circuit**

![image](https://github.com/user-attachments/assets/b1b2b589-7190-41d7-bea1-d92d66c21954)

Following the aforementioned modifications, the circuit diagram is as shown above. While other waveforms functioned correctly, an issue arose with clk0_5, the 0.5 Hz clock signal, which exhibited irregular frequency. The first two waveforms correctly represented 0.5 Hz, but the third waveform displayed a "waiting issue." Consequently, it was concluded that the signal should not be connected to the last 74160 counter. The solution involved deriving the signal from clk1 and then dividing it by two to generate the 0.5 Hz signal.

The final simulation waveforms are as follows, demonstrating a perfect transition from 1000 Hz to 100 Hz, with each waveform containing 10 complete cycles. Similarly, the transition from 100 Hz to 10 Hz also exhibited 10 complete cycles within each waveform.

**Figure 1.6 Final Simulation Waveform 1**

![image](https://github.com/user-attachments/assets/b9b6a371-a33b-4f4c-aa87-2f15d4821242)

**Figure 1.7 Final Simulation Waveform 2**

![image](https://github.com/user-attachments/assets/42e367b4-a02b-45c8-8dc1-86ed3276bbd8)

**Figure 1.8 Final Simulation Waveform 3**

![image](https://github.com/user-attachments/assets/68af634e-3c5b-414f-b62d-36df562400d3)

**Figure 1.9 Final Simulation Waveform 4**

![image](https://github.com/user-attachments/assets/253f9967-7c02-4782-8499-513be14457de)

**Figure 1.10 Final Simulation Waveform 5**

![image](https://github.com/user-attachments/assets/1d273c97-a5d4-4403-8167-24e48838e486)

## 1.2 Pseudo-Random Number Generator (random) Design Principles and Simulation Waveforms

**Figure 1.11 Circuit Diagram of the random Module**

![image](https://github.com/user-attachments/assets/0694c547-1a53-4c21-b39e-c3efc5e70c3c)

Pure circuitry cannot achieve true randomness; hence, the following discussion is based on pseudo-random number generation methods. Initially, a series of square wave signals are generated using the 74161 counter, with output signals labeled ABCD. These output signals are then connected to a 4-to-16 line decoder to produce a 16-bit binary code. If these binary codes are sequentially processed through an encoder, a sequential 4-bit binary code is obtained.

To generate pseudo-random numbers, the connections between the decoder and encoder need to be scrambled. However, this method cannot avoid the occurrence of an all-zero (0000) state. In such a case, the button does not need to be pressed to satisfy the trigger condition, but since one of the trigger conditions requires the button to be pressed, a contradiction arises. To resolve this, a module can be introduced that flips one bit when an all-zero (0000) state is detected, thereby preventing the occurrence of an all-zero state. This ensures the rationality of the pseudo-random number generation process.

**Figure 1.12 Simulation Waveform**

![image](https://github.com/user-attachments/assets/2adb46a6-5c04-48c1-87c4-e74c8098ec08)

The simulation waveform shows that the ABCD output lacks obvious regularity and does not exhibit an all-zero state. However, from a long-term perspective, there is a certain regularity, but the regularity between adjacent states can be considered negligible, thus conforming to the characteristics of pseudo-random number generation.

## 1.3 Comparator Module (compare) Design Principles and Simulation Waveforms

**Figure 1.13 Circuit Diagram of the compare Module**

![image](https://github.com/user-attachments/assets/4bf8af70-8004-4792-9fae-c54bf533f74a)

The core component of the comparator is the 7485, which is used to compare four signals and output the result. The 74160 counter below counts at 0.5-second intervals, triggering a detection each time to determine if the correct button has been pressed. The two outputs on the right, sc_n and false, represent the successful press (active low) and the state of pressing the wrong button, respectively.

The D flip-flop in this design serves as a latch. It latches the successful press signal until the end of a 0.5 Hz cycle, ensuring signal stability and accuracy.

The simulation waveform below simulates scenarios of pressing the correct and wrong buttons, as well as not pressing any button.

**Figure 1.14 Simulation Waveform**

![image](https://github.com/user-attachments/assets/9d786ec6-d932-446c-810d-2d2dbbaef878)

## 1.4 Dynamic Digital Tube Scanning Signal Generator (dy_gen) Design Principles and Simulation Waveforms

**Figure 1.15 Circuit Diagram of the dy_gen Module**

![image](https://github.com/user-attachments/assets/14bffea6-8572-4a86-af82-a504eefd404e)

This module generates scanning signals. Within each clock cycle, one of the selection signal (sel) lines will have a waveform, while the other sel signal lines will not, thereby generating a periodic sequence signal such as 1000, 0100, 0010, 0001.

The entire module utilizes four D flip-flops. The output of each flip-flop is connected to the input of the next flip-flop, with the input of the first flip-flop connected to the NOR of the sel1, sel2, and sel3 signal lines. This means that when all sel signal lines are 0, a 1 is written to the first D flip-flop, achieving the effect of "pushing the waveform backward." In this way, the module can generate high-frequency scanning signals. Whenever a waveform appears on a sel signal line, the dynamic scanning tube will display on that signal line, followed by the next digital tube. This cycle repeats, achieving continuous display.

The simulation waveform below shows that it meets the design expectations.

**Figure 1.16 Simulation Waveform**

![image](https://github.com/user-attachments/assets/486f75b5-06fe-41db-bf93-d9891c5bf5c0)

## 1.5 Design Principle and Simulation Waveform of the Timer Dynamic Digital Tube Display Module dy_time

**Figure 1.17 Circuit Diagram of the dy_time Module**

![image](https://github.com/user-attachments/assets/54a0d09c-8d2e-48d9-84e8-2f183979bbbd)

**Figure 1.18 Partial Enlargement 1**

![image](https://github.com/user-attachments/assets/add5cf0b-59e0-4ea3-88e7-93ed81c02858)

**Figure 1.19 Partial Enlargement 2**

![image](https://github.com/user-attachments/assets/7b01ccd7-539e-42d7-8be5-019bc2c1524b)

**Figure 1.20 Partial Enlargement 3**

![image](https://github.com/user-attachments/assets/e2855f36-c247-41c8-8b64-4cb4bad36012)

**Figure 1.21 Partial Enlargement 4**

![image](https://github.com/user-attachments/assets/a63dc9bb-8998-4e0f-8eed-1699dcece21d)

This module is relatively complex, integrating dynamic scanning tube (bus control) display, 10-time counting, frequency division counting with BCD code output, and latching functions.

The 74161 counter in the upper left corner is connected to a 0.5Hz clock signal. When the count reaches 10, an end_flag signal is output, indicating the completion of 10 counts, which corresponds to a 20-second test duration. Simultaneously, this signal is sent to the clock source of the flip-flop in the lower right corner and the ENT pin of the 74160 in the middle section. This signal can disable the counter, thereby stopping the count and achieving the effect of ending the test after 20 seconds. After the counting is completed, the signal on the left continues to be written, maintaining the value 1101, which remains unchanged for 20 seconds until the reset is completed.

The four 74160 counters in the middle constitute the counting module, initially connected to a 100Hz clock signal. The clock input (CLK) of each 74160 is connected to the D pin of the previous 74160, indicating that a clock pulse is triggered every 10 counts, thereby realizing a decimal counting relationship. Additionally, the first 74160 can control the start and end of the timing for the three 74160 counters below. Furthermore, the external sc pin can asynchronously stop the timer, achieving the function of stopping the timer when the correct button is pressed.

The circuit in the lower right corner is used for failure judgment. When the elapsed time exceeds 10 seconds, the D flip-flop writes a 1, the OR gate outputs a 1, the false signal becomes 1, and the success signal becomes 0. The D flip-flop maintains the state of success, which will play a foundational role in the pass-fail module.

In the bus refresh section, the four counter signals are connected to the bus, and the sel signal is provided to the enable terminal of the 74244. When enabled, the corresponding signal is sent out. By sequentially sending the signals in segments, scanning is achieved. When the scanning cycle is shortened, the refresh frequency becomes imperceptible to the human eye, thereby achieving an effect similar to constant illumination. Finally, through the 7448 encoding, the signal is sent to the digital tube, achieving the display effect.

## 1.6 Design Principle and Simulation Waveform of the Pass/Fail Dynamic Digital Tube Display wr_pa

**Figure 1.22 Circuit Diagram of the wr_pa Module**

![image](https://github.com/user-attachments/assets/a3abf399-e53c-4997-9a75-19bf1244eaf6)

**Figure 1.23 Partial Enlargement**

![image](https://github.com/user-attachments/assets/a01d9e98-4841-45fc-a236-711aa0f23514)

The function of this module is to display the words "PASS" and "FAIL" in different states. The input signals are pass and fail, with a value of 1 indicating validity. Therefore, the core idea is that when the pass or fail signal is valid, the sel line only enables the corresponding 74244 chip for the respective word. The specific implementation method involves performing an OR operation on the corresponding sel line signal and the inverted input pass/fail signal, and then outputting the result. Since the combination of fail and pass signals can only be 01 or 10, this achieves the output requirements under specific conditions.

During the simulation process, the clock function can be efficiently used to generate simulated sel signals, as shown in the figure.

**Figure 1.24 Demonstration of the Clock Function Usage**

![image](https://github.com/user-attachments/assets/0666a848-1871-47b9-be7d-6ae6a10e60db)

The simulated waveform is as follows, showing periodic digital tube signals. When both are 0, the output is in a high-impedance state, i.e., no display, thus avoiding conflict with the timing signals.

**Figure 1.25 Waveform Simulation Diagram**

![image](https://github.com/user-attachments/assets/a7ad5779-2bba-40e7-83d8-0fd1676da5d8)

## 1.7 Design Principle of the Error Count Display wrongcount

**Figure 1.26 Circuit Diagram of the wrongcount Module**

![image](https://github.com/user-attachments/assets/9c854c61-dff8-4a28-9b26-7b39cfe735fb)

This module simply counts and outputs through the 7448, and will not be elaborated further.

## 1.8 Design Principle of the Random Number All-Zero Handling Module all0to1

**Figure 1.27 Circuit Diagram of the all0to1 Module**

![image](https://github.com/user-attachments/assets/661e454a-86ec-4859-acdd-0dce488b2625)

Simplification and logical expression are achieved through Karnaugh maps, as shown in the table below.
**table 1**
AB\CD 00 01 11 10
00 1 0 0 0
01 0 0 0 0
11 1 1 1 1
10 1 1 1 1

# Signal Connection Debugging and Analysis of Unit Modules in the Integrated Circuit

## 2.1 Integrated Circuit Diagram

**Figure 2.1: Overall Circuit Diagram**

![image](https://github.com/user-attachments/assets/1e90e6d9-153d-4a7a-b395-65b335d0df2b)

## 2.2 Connection and Functional Description of Unit Circuit Modules

### 2.2.1 Clock Source Distribution and Status LED Display

The Dy_gen module requires a 1000 Hz clock, while the dy_time module requires clocks of 0.5 Hz, 100 Hz, 10 Hz, 1 Hz, and 1000 Hz. The compare module needs clocks of 0.5 Hz and 2 Hz, and the random module requires a 0.5 Hz clock. The fdiv module, on the other hand, requires an external clock source, for which a 1 kHz external clock input was selected.

The clock from Clk2 is connected to the Dy_gen module, and then routed to four LEDs and a seven-segment display. This setup achieves the effect of a system status indicator, where the seven-segment display shows a continuous rotating pattern, and the LEDs exhibit a running light effect.

**Figure 2.2: Status Display Circuit Diagram**

![image](https://github.com/user-attachments/assets/4eeafe2e-d2c9-47a4-ab4b-24e40a332637)

### 2.2.2 Key Input Section

**Figure 2.3: Key Input Circuit Diagram**

![image](https://github.com/user-attachments/assets/6557c994-adf4-4432-8f99-92fc10d0463f)

The lower left section of the diagram represents the key signal input. Four keys are connected, and their signals are inverted before being fed into the compare module. Additionally, the four lines are ORed together and input to the key_press port, which will be set to 1 if any key is pressed.

The random module, after receiving the clock signal, continuously generates pseudo-random signals, which are then input to the compare module for comparison. The outputs of the compare module, namely sc_n, bell, and false, are sent for further processing.

The random signals are also used to control the lighting of the LEDs. Due to the influence of key presses, these signals need to be further processed with the endflag signal from the dy_time module, ensuring that all LEDs turn off after the test is completed.

### 2.2.3 Error Counting Display Section

**Figure 2.4: Error Counting Circuit Diagram**

![image](https://github.com/user-attachments/assets/46bc99f8-3c6b-43b5-9885-4ace935b0e32)

The wrong_in port receives the false signal from the compare module. Each time the false signal is triggered, a counting signal is sent to the wrongcount module, which is then displayed on a static seven-segment display. The reset signal is connected to the start key, meaning that the error count is reset when the test is restarted. The 4timeflag6 signal is connected to an indicator light, indicating that if the error count exceeds four, the test is considered a failure, and a "fail" message is displayed. Additionally, OR and AND gates are added to enhance the test pass conditions. If the time is less than 10 seconds but the error count exceeds four, a "fail" is displayed. Only when both conditions are met is a "pass" displayed.

### 2.2.4 Counter Dynamic Seven-Segment Display (Average Time, Pass/Fail)

**Figure 2.5: Dynamic Seven-Segment Display Circuit Diagram**

![image](https://github.com/user-attachments/assets/6c663b19-d7c3-45e1-8c6e-efa5caf3f986)

This is the most complex wiring section. The dy_gen module, after receiving the clock signal, generates continuous refresh signals. During the refresh cycle, signals are sent to the seven-segment display, causing the corresponding segment to display the appropriate number. Since the 74244 chip is active low, the integrated circuit deliberately provides an inverted channel, which is connected to the dynamic seven-segment display's segment selection to achieve the refresh function.

The dy_time module is connected to the corresponding clock and refresh signals. Since this module also includes a bus refresh circuit, it also requires the refresh signal. The sc input receives the sc_n signal from the previous stage, transmitting the correct key press signal. The output abcdefg signals from the seven-segment display are routed through the 74244 chip to the display via the bus, which will be analyzed later. The failflag and success signals are connected to the output LED pins to display the status.

For the wr_pa (wrong_pass) module, the inputs are the refresh signal and the fail/pass signals, and the outputs are the corresponding binary signals for the fail/pass letters. This module also includes a bus refresh design, similar to the previous description.

In the external bus design, the seven-segment signals from both modules are connected to the 74244 chip. When endflag is 1, indicating the test is completed, the signal is NORed with a 0.5 Hz clock signal to achieve alternating displays of the average time and pass/fail status. Additionally, the enable signals of the two modules are inverted to avoid refresh conflicts.

The average time is achieved by moving the decimal point. The endflag signal is ANDed with sel1 and sel2, and then connected to the 74244 chip to participate in the refresh. When the test ends, endflag is 1, and its signal is ANDed with sel1/sel2 (one inverted and the other not), resulting in a moving decimal point. When the test is not completed, endflag is 0, and the decimal point remains in its original position.

## 2.3 Input and Output Waveform Simulation

**Figure 2.6: Simulation Waveform 1**

![image](https://github.com/user-attachments/assets/f2e3c807-3e9a-45c6-9275-ee2a789e7188)

As shown in the figure above, when the corresponding key is pressed, the bibi signal responds, causing the speaker to emit a sound. Simultaneously, the dy_time_show group pauses, indicating that the timer stops counting. However, some issues were encountered during debugging, such as no response when key 4 was pressed, although it worked in actual testing.

**Figure 2.7: Simulation Waveform 2**

![image](https://github.com/user-attachments/assets/8851566d-5409-442c-bdd0-bb7ed445a33b)

When the start key is pressed, the counting restarts, as shown in the figure above, adding an additional 20 seconds to the timer.

## 2.4 Debugging and Analysis

### 2.4.1 Successful Test Condition Verification

**Figure 2.8: Test Pass Condition 1**

![image](https://github.com/user-attachments/assets/1de07862-9684-42af-872c-e778db49371e)

**Figure 2.9: Test Pass Condition 2**

![image](https://github.com/user-attachments/assets/0d78417f-4619-429e-b367-be3f8863c63c)

If the number of incorrect key presses is less than four and the time is less than 10 seconds, the test is considered passed, and the L7 LED lights up, displaying "pass."

### 2.4.2 Timeout Failure Test Condition Verification

**Figure 2.10: Timeout Condition 1**

![image](https://github.com/user-attachments/assets/68b0e3d4-1492-4015-94a4-a402ae01cdd4)

**Figure 2.11: Timeout Condition 2**

![image](https://github.com/user-attachments/assets/9d178ff9-1958-469f-9767-7bb40787dc91)

If the time exceeds 10 seconds, the L8 LED lights up, displaying "fail," and the test is considered failed.

### 2.4.3 Excessive Incorrect Key Presses Failure Test Condition Verification

**Figure 2.12: Excessive Errors Condition 1**

![image](https://github.com/user-attachments/assets/3c195eb8-d8a5-45d5-a739-827a8fb1e6bf)

**Figure 2.13: Excessive Errors Condition 2**

![image](https://github.com/user-attachments/assets/3b228c11-3184-49a1-836e-32e117825828)

Even if the time is less than 10 seconds, if the number of incorrect key presses exceeds four, the test is considered failed, displaying "fail," and both L8 and L6 LEDs light up.

# 3 Anomalies and Solutions

## 3.1 Issue with the Error Counting Module

The error counting module exhibits a problem where the count continues to increment even after the display shows "fail" (indicating the end of measurement) and the button is pressed. Theoretically, the circuit should enter a "pause" state upon completion of the test, requiring reactivation through the control circuit to resume counting. The control circuit consists of the start button and surrounding triggers. The current solution involves enhancing the connection between the start button and the counting circuit, and increasing the control input signals within the integrated block to prevent this issue.

## 3.2 Dynamic Scan Tube Refresh Issue

For the refresh signal, a 1000Hz signal was utilized, whereas the course material suggested the use of a 100Hz signal, which was also adopted by other students. The 100Hz signal resulted in flickering issues, which were completely resolved by using the 1000Hz signal. However, it is uncertain whether this is a perceptual issue; at high refresh rates, the flickering of digits in the 0.01s position is quite noticeable. Using the high-speed photography feature on a smartphone, the refresh process was captured, confirming that the design is correct and that the digits do indeed change one by one, albeit too quickly at 0.01s. The photographs taken are shown below.

**Figure 3.1 High-Speed Camera Image 1**

![image](https://github.com/user-attachments/assets/54214898-fa84-4e84-ae6a-59ff37eeded0)

**Figure 3.2 High-Speed Camera Image 2**

![image](https://github.com/user-attachments/assets/e8b64ac3-1880-4a5e-82b0-057f97d40d53)

## 3.3 Discrepancy Between Timing Simulation Waveform and Functional Simulation

**Figure 3.3 Timing Simulation Diagram**

![image](https://github.com/user-attachments/assets/2dbced48-1320-4f22-8535-91840f1db921)

For instance, at the lamp position, some glitches were observed. These may be caused by cumulative delays from various integrated components, leading to gaps during processing.
