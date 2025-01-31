## Installing and Testing Quartus Prime Lite

### 1. Install Quartus Prime Lite
Just install it as-is—don't change any settings, just keep clicking **"Next."**  

🔗 **Download Link:**  
[Intel Quartus Prime Lite Edition (v23.1.1) for Windows](https://www.intel.com/content/www/us/en/software-kit/825278/intel-quartus-prime-lite-edition-design-software-version-23-1-1-for-windows.html)

---

### 2. Testing with `./Examples/four_inputs.v`
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

[Download four_inputs_output.pdf](../Examples/four_inputs_output.pdf)