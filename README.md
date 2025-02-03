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

## RV32I Base Integer Instructions

1. **Create `opcode_decoder` Module**  
   - A module that examines the first 7 bits (opcode) of a 32-bit instruction and identifies the core instruction format (e.g., R, I, S, B, U, J).

2. **Add Debugging Statements**  
   - Implement "print statements" to display the identified format for each instruction during testing. This helps in verifying that the opcode decoding is working correctly.

3. **Create Instruction Splitters**  
   - A utility to divide the 32-bit instruction into its components (e.g., opcode, func3, func7, registers, immediate). This is useful for debugging and understanding how the instruction is interpreted.

I think this is a good stopping point for today (01/31/25 @ 1:48 AM). Next time, I'll focus on writing sanity checks.

02/02/2025 @ 2:30pm
I haven’t added any sanity checks yet. 
I spent most of my time upfront mapping out the instruction fields and structuring the design. 
I also leveraged an LLM to help generate some of the wiring, which sped up the process. Overall, the structure of the diagram appears correct.
Ignore the last section of the diagram.

[View Progress - 02/02/2025](./VisualProgress/Progress02_02_2025.pdf)