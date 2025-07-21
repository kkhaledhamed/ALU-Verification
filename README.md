# Signed 4-Bit ALU Verification projects with different methodologies

![Verification](https://img.shields.io/badge/Verification-Cocotb%20%7C%20SystemVerilog-blue) 
![HDL](https://img.shields.io/badge/HDL-Verilog-orange)
![Simulator](https://img.shields.io/badge/Simulator-QuestaSim%20%7C%20Xcelium-green)

## 📋 Table of Contents
- [Design Specifications](#-design-specifications)
- [Operations](#-operations)
- [Testbench Architectures](#-testbench-architectures)
- [Test Cases](#-test-cases)
- [Tools Used](#-tools-used)
- [Getting Started](#-getting-started)
- [Verification Metrics](#-verification-metrics)
- [License](#-license)

## 🎯 Design Specifications
| Signal    | Description                          | Width     |
|-----------|--------------------------------------|-----------|
| `clk`     | Input clock signal                   | 1-bit     |
| `reset`   | Asynchronous reset                   | 1-bit     |
| `Opcode`  | Operation selector                   | 2-bit     |
| `A`       | Input A (2's complement)             | 4-bit     |
| `B`       | Input B (2's complement)             | 4-bit     |
| `C`       | Output (2's complement)              | 5-bit     |

## 🔧 Operations
| Opcode | Operation        | Description               |
|--------|------------------|---------------------------|
| `00`   | Add              | A + B                     |
| `01`   | Subtract         | A - B                     |
| `10`   | Bitwise NOT      | ~A                        |
| `11`   | Reduction OR     | OR all bits of B (&#124;B) |

## 🏗️ Testbench Architectures
### SystemVerilog Class-Based
```mermaid
flowchart TB
    Test --> Env
    Env --> Scoreboard
    Env --> Generator --> Driver --> Interface --> DUT
    DUT --> Interface --> Monitor --> Scoreboard
Cocotb (Python-Based)
Diagram
Code









🧪 Test Cases
Reset Tests
Verify output resets to 0 when reset is asserted

Confirm normal operation resumes after reset release

Arithmetic Tests
Test Case	A	B	Opcode	Expected Result
MAXNEG + MAXNEG	-8	-8	00	-16 (overflow)
MAXPOS + MAXNEG	+7	-8	00	-1
Zero Subtraction	0	0	01	0
Logical Tests
Bitwise NOT with boundary values (-8, +7, 0)

Reduction OR with all 0s and non-zero patterns

🛠️ Tools Used
Simulators: QuestaSim, Xcelium

Verification:

Cocotb (Python)

SystemVerilog (UVM-like)

Editors: VS Code, EDA Playground

🚀 Getting Started
bash
# Install Cocotb
pip install cocotb

# Run Cocotb tests
make SIM=questa

# Run SystemVerilog tests
vsim -do "run -all" tb_alu
📊 Verification Metrics
Error counter (should be 0)

Correct operation counter

Boundary coverage (100% achieved)
