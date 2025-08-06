# 16-bit Function Unit & Opcode Design

This project implements a 16-bit function unit with 13 operations integrated into a simple computer model. It also includes the design and simulation of a custom opcode to control the system, all modeled using Verilog.

## 📌 Objectives

- Design a function unit that performs arithmetic, logic, and shift operations.
- Create a modular, scalable circuit architecture using 8- and 16-bit data paths.
- Implement and simulate a custom opcode and instruction decoder.
- Evaluate performance in terms of transistor count and propagation delay.

## 🧠 Functional Overview

The function unit supports 13 operations across three categories:

- **Arithmetic:** `A + B`, `A`, `A - B`, `-B`, `B - A`, `-A`
- **Logic:** `NAND`, `NOR`, `A'`
- **Shift:** `MOD8`, `DEV4`, `CIR-R`, `CIR-L`

The design is modular, using 1-bit muxes scaled to 16 bits, allowing for easier extension and efficient reuse of components.

## 🏗️ Design Architecture

- **Adder:** Built with eight 1-bit full adders, including carry-in logic for subtraction and negation.
- **Logic Unit:** Uses a mux to switch between logic operations.
- **Shift Unit:** Handles bitwise shift operations with zero-padding where needed.
- **Status Bits:** Overflow, carry-out, zero, and negative flags are implemented based on outputs.

## ♻️ Opcode Structure

Each operation is tied to a custom 16-bit opcode. Control lines are assigned as follows:

- `MB`, `FS[3:0]`, `MD`, `RW`, `MW`, `PL`, `JB`, and `BC` map to specific bits within the opcode.
- Example: `A + B` → `Opcode: 0000000`, `FS: 0000`, `RW: 1`, etc.

## 🧪 Simulation

The implementation was validated using simulation:

- Functional correctness confirmed across all operations.
- Control words correctly triggered intended datapath behavior.

## 🧽 Transistor Count

- **Function Unit:** \~3400 transistors
- **Instruction Decoder:** \~30 transistors
- Trade-offs were made between transistor count and code readability for ease of debugging.

## ⏱️ Propagation Delay

Each module’s delay was analyzed, and the critical path was identified. The overall delay for the circuit was estimated at **1650ps**.

## ✅ Conclusion

This project successfully implements a scalable, functional 16-bit function unit and demonstrates how opcodes interact with datapath control logic. It emphasizes modular Verilog design, simulation-driven validation, and thoughtful optimization in terms of performance and readability.

---

## 📁 Project Structure

```
/function_unit/
├── full_adder.v
├── mux.v
├── function_unit.v
├── instruction_decoder.v
├── testbenches/
├── simulation_outputs/
└── README.md
```

---

## 🔧 Technologies

- **Language:** Verilog
- **Simulation Tools:** ModelSim / Vivado (or your preferred simulator)
- **Platform:** Quartus / FPGA-compatible hardware (if implemented physically)

