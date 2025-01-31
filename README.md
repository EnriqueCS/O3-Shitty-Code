# Out-of-order Execution

I'm bored and didn’t pay attention in class, so I’m going to try tackling it on my own.

I'll document everything in a structured, step-by-step format, similar to a "Let's Play" tutorial, making it easy to follow along and learn from my process.

## Project Details
- **Date Started:** 01/30/2025 @ 10:35 PM  
- **Hardware Description Language:** SystemVerilog  

[Read More - Running Verilog](./Guides/BasicVerilog.md)

Intel **Quartus Prime** is software for designing and programming **Intel FPGAs** using Verilog or VHDL. 
It helps turn your code into a working circuit, test it, and load it onto the FPGA.

[Read More - Simple Quartus](./Guides/BasicQuartus.md)

We are choosing the RISC-V instruction set because it is open-source, well-documented, and widely supported, making it an ideal choice for our out-of-order processor implementation.

[Read More - RISC-V Reference](https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf)

## Intuitive Approach: Start with the Decode Stage

The **decode stage** in a RISC-V processor interprets the fetched instruction and prepares it for execution. It breaks down the instruction into key fields:

- **Opcode** – Determines the instruction type (ALU, load, store, branch, etc.).
- **rs1, rs2** – Source registers.
- **rd** – Destination register.
- **func3, func7** – Function codes specifying the exact operation (e.g., `ADD` vs. `SUB`).
- **Immediate (imm)** – Constant value used in certain instructions (e.g., offsets, branch targets).