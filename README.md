# 🔍 ALU Verification Project

![Verification](https://img.shields.io/badge/Verification-Cocotb%20%7C%20SystemVerilog-blue)  
![HDL](https://img.shields.io/badge/HDL-Verilog-orange)  
![Simulator](https://img.shields.io/badge/Simulator-QuestaSim%20%7C%20Xcelium-green)

---

## 📋 Table of Contents
- [🎯 Design Specifications](#-design-specifications)
- [🔧 Operations](#-operations)
- [🏗️ Testbench Architectures](#-testbench-architectures)
- [🧪 Test Cases](#-test-cases)
- [🛠️ Tools Used](#-tools-used)
- [🚀 Getting Started](#-getting-started)
- [📊 Verification Metrics](#-verification-metrics)
- [📄 License](#-license)

---

## 🎯 Design Specifications

| Signal   | Description              | Width    |
|----------|--------------------------|----------|
| `clk`    | Input clock signal       | 1-bit    |
| `reset`  | Asynchronous reset       | 1-bit    |
| `Opcode` | Operation selector       | 2-bit    |
| `A`      | Input A (2's complement) | 4-bit    |
| `B`      | Input B (2's complement) | 4-bit    |
| `C`      | Output (2's complement)  | 5-bit    |

---

## 🔧 Operations

| Opcode | Operation     | Description               |
|--------|---------------|---------------------------|
| `00`   | Add           | A + B                     |
| `01`   | Subtract      | A - B                     |
| `10`   | Bitwise NOT   | ~A                        |
| `11`   | Reduction OR  | OR all bits of B (`|B`)   |

---

## 🏗️ Testbench Architectures

### ➤ SystemVerilog Class-Based

```mermaid
flowchart TB
    Test --> Env
    Env --> Scoreboard
    Env --> Generator --> Driver --> Interface --> DUT
    DUT --> Interface --> Monitor --> Scoreboard
```

### ➤ Cocotb (Python-Based)

- Python-driven test generation  
- Co-simulation with Verilog using GPI interface  
- Self-checking via Python assertions  

---

## 🧪 Test Cases

### 🔁 Reset Tests
- ✅ Assert reset and confirm output `C = 0`
- ✅ Release reset and confirm normal functionality resumes

### ➕ Arithmetic Tests

| Test Case            | A   | B   | Opcode | Expected Result |
|----------------------|-----|-----|--------|-----------------|
| MAXNEG + MAXNEG      | -8  | -8  | 00     | -16 (overflow)  |
| MAXPOS + MAXNEG      | +7  | -8  | 00     | -1              |
| Zero Subtraction     |  0  |  0  | 01     | 0               |

### 🧠 Logical Tests
- ✅ Bitwise NOT with boundary values (`-8`, `+7`, `0`)
- ✅ Reduction OR with all-zeros and various non-zero patterns

---

## 🛠️ Tools Used

- **Simulators:**  
  - QuestaSim  
  - Xcelium  

- **Verification Languages & Libraries:**  
  - Cocotb (Python-based)  
  - SystemVerilog (UVM-like methodology)

- **Development Environments:**  
  - VS Code  
  - EDA Playground  

---

## 🚀 Getting Started

### ▶️ Cocotb Flow
```bash
# Install Cocotb
pip install cocotb

# Run Cocotb tests
make SIM=questa
```

### ▶️ SystemVerilog Flow
```bash
# Run SystemVerilog testbench
vsim -do "run -all" tb_alu
```

---

## 📊 Verification Metrics

- ✅ Error Counter: `0`  
- ✅ Correct Operations Counter: All Passed  
- ✅ Code Coverage: **100% Achieved**

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
