# O3-Shitty-Code

I'm bored and didn’t pay attention in class, so I’m going to try tackling it on my own.

I'll document everything in a structured, step-by-step format, similar to a "Let's Play" tutorial, making it easy to follow along and learn from my process.

## Project Details
- **Date Started:** 01/30/2025 @ 10:35 PM  
- **Hardware Description Language:** SystemVerilog  

### 1. Install Icarus Verilog
Install Icarus Verilog, a popular open-source Verilog simulation and synthesis tool:
```sh
sudo apt update
sudo apt install iverilog
```

### 2. Navigate to the Project Directory
Change your current directory to the Examples folder where your Verilog files are located:
```sh
cd Examples
```

### 3. Compile and Run a Verilog File
Use iverilog to compile your Verilog source file (hello.v) into an output file (hello.out):
```sh
iverilog -o hello.out hello.v
vvp hello.out
```

Intel **Quartus Prime** is software for designing and programming **Intel FPGAs** using Verilog or VHDL. 
It helps turn your code into a working circuit, test it, and load it onto the FPGA.

## Installing and Testing Quartus Prime Lite

### 1. Install Quartus Prime Lite
Just install it as-is—don't change any settings, just keep clicking **"Next."**  

🔗 **Download Link:**  
[Intel Quartus Prime Lite Edition (v23.1.1) for Windows](https://www.intel.com/content/www/us/en/software-kit/825278/intel-quartus-prime-lite-edition-design-software-version-23-1-1-for-windows.html)

---

### 2. Testing with `four_inputs.v`
We will use the `four_inputs.v` file to test Quartus.  
This file should have **4 input wires** and **1 output** that follows the logic:  
**(v1 AND v2) OR (v3 AND v4).**  

Once compiled, a **diagram** should pop up showing the logic connections.

---

### 3. Setting Up the Project
1. **Create a New File:**  
   - Select **Verilog HDL File**  

2. **Paste the `four_inputs.v` Code:**  
   - Open the new file  
   - Paste the `four_inputs.v` content  
   - Save the file  

3. **Follow the Project Setup Prompt:**  
   - After saving, Quartus will prompt you to create a project  
   - **Proceed with the setup**  

---

### 4. Running Analysis and Viewing the Logic Diagram
1. Click **"Start Analysis & Synthesis"**  
2. Once completed, go to:  
   **Tools > Netlist Viewers > RTL Viewer**  
3. **Tada! 🎉**  
   You can now see how everything is connected in a visual diagram.

[Download four_inputs_output.pdf](./Examples/four_inputs_output.pdf)
