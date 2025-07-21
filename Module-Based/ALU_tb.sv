module ALU_tb ();
// Signals Declaration
logic clk, reset;
logic signed [3:0] A;  // Input data A in 2's complement
logic signed [3:0] B;  // Input data B in 2's complement
logic [1:0] Opcode;    // The opcode
logic signed [4:0] C_dut; // ALU output in 2's complement
logic signed [4:0] C_expected; // ALU expected output in 2's complement
// Counters
integer error_counter = 0;
integer correct_counter = 0;
// Parameters
localparam MAXPOS = 7;
localparam MAXNEG = -8;
localparam ADD = 2'b00;  // A + B
localparam SUB = 2'b01;  // A - B
localparam NOT_A = 2'b10;  // ~A
localparam REDUCTION_OR_B = 2'b11;  // |B
// DUT Instantiation
ALU DUT (clk, reset, Opcode, A, B, C_dut);
// Clock Generation
initial begin
  clk = 0;
  forever
    #5 clk = ~clk;
end
// Stimulus Generator
initial begin
  // Initialize signals
  A = 0;
  B = 0;
  Opcode=0;
  // Reset toggling for coverage
  reset = 0;
  repeat(3) begin
    reset = ~reset;
    @(negedge clk);
  end
  // LABEL1, Check Reset
  reset_check();
  // Boundary tests for Not_A
  // LABEL2, Check MAXNEG on Not_A 
  A = MAXNEG;
  check_ALU_result(Not_A);
  // LABEL3, Check MAXPOS on Not_A
  A = MAXPOS;
  check_ALU_result(Not_A);
  // LABEL4, Check 0 on Not_A
  A = 0;
  check_ALU_result(Not_A);
  // Boundary tests for Add & Sub 
  // LABEL5, Check MAXNEG & MAXNEG on both ADD & Subtract
  A = MAXNEG;
  B = MAXNEG;
  check_ALU_result(Add);
  check_ALU_result(Sub); 
  // LABEL6, Check MAXNEG & Zero on both ADD & Subtract
  A = MAXNEG;
  B = 0;
  check_ALU_result(Add);
  check_ALU_result(Sub);  
  // LABEL7, Check MAXNEG & MAXPOS on both ADD & Subtract
  A = MAXNEG;
  B = MAXPOS;
  check_ALU_result(Add);
  check_ALU_result(Sub);  
  // LABEL8, Check 0 & MAXNEG on both ADD & Subtract
  A = 0;
  B = MAXNEG;
  check_ALU_result(Add);
  check_ALU_result(Sub);  
  // LABEL9, Check 0 & MAXPOS on both ADD & Subtract
  A = 0;
  B = MAXPOS;
  check_ALU_result(Add);
  check_ALU_result(Sub); 
  // LABEL10, Check MAXPOS & MAXNEG on both ADD & Subtract
  A = MAXPOS;
  B = MAXNEG;
  check_ALU_result(Add);
  check_ALU_result(Sub);  
  // LABEL11, Check MAXPOS & Zero on both ADD & Subtract
  A = MAXPOS;
  B = 0;
  check_ALU_result(Add);
  check_ALU_result(Sub);  
  // LABEL12, Check 0 & 0 on both ADD & Subtract
  A = 0;
  B = 0;
  check_ALU_result(Add);
  check_ALU_result(Sub);  
  // LABEL13, Check MAXPOS & MAXPOS on both ADD & Subtract
  A = MAXPOS;
  B = MAXPOS;
  check_ALU_result(Add);
  check_ALU_result(Sub); 
  // Boundary tests for ReductionOR_B
  // LABEL14, Check MAXNEG on Reduction OR
  B = MAXNEG;
  check_ALU_result(ReductionOR_B);
  // LABEL15, Check MAXPOS on Reduction OR
  B = MAXPOS;
  check_ALU_result(ReductionOR_B);  
  // LABEL16, Check 0 on Reduction OR
  B = 0;
  check_ALU_result(ReductionOR_B);
  //LABEL17 , Check error and correct counters
  $display("At the end, Number of error counts = %d | Number of correct counts = %d", error_counter, correct_counter);
  $stop;
end
// Task to check ALU result
task check_ALU_result(input logic [1:0] Op);
  Opcode = Op;  // Set the Opcode
  case (Op)
    Add: C_expected = A + B;  // Add
    Sub: C_expected = A - B;  // Sub
    Not_A: C_expected = ~A;  // Not_A
    ReductionOR_B: C_expected = |B;  // Reduction OR
  endcase
  @(negedge clk);
  if (C_expected !== C_dut) begin
    error_counter++;
    $display("Error: Opcode = %b | A = %d | B = %d | Expected = %d | Got = %d", Opcode, A, B, C_expected, C_dut);
  end else begin
    correct_counter++;
  end
endtask
// Task to check reset functionality
task reset_check();
  reset = 1;
  @(negedge clk);
  if (C_dut !== 0) begin
    error_counter++;
    $display("Error during reset: C_dut should be 0, but got %d", C_dut);
  end
  reset = 0;
endtask
// Test Monitor & Results
initial begin
  $monitor("Time = %t | A = %d | B = %d | C_dut = %d | C_expected = %d | Opcode = %b | Error Counter = %d | Correct Counter = %d",
           $time, A, B, C_dut, C_expected, Opcode, error_counter, correct_counter);
end
endmodule

