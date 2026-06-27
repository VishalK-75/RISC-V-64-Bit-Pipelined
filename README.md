# 5-Stage Pipelined 64-bit RISC-V Processor Core

A hardware design and implementation of a 5-stage concurrent pipelined processor based on the open-source **RISC-V (RV64I) Architecture**, modeled entirely in **Verilog HDL**.

## 🛠️ Microarchitectural Overview
* **Concurrent Pipeline Datapath:** Dividid into Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), and Writeback (WB) cycles.
* **Bypassing & Forwarding Logic:** Centralized Hazard Unit monitors operational register targets to route computed data values directly back to the ALU inputs, minimizing raw data dependency delays.
* **Load-Use Protection:** Automatically forces a single-cycle hardware pipeline stall bubble when an instruction immediately reads a register target currently being retrieved from Data RAM.

## 📁 Workspace Layout
* `/rtl` : Synthesizable Verilog design modules (`Pipeline_64_Top.v`, `Hazard_Unit.v`, etc.)
* `/waves` : GTKWave signal logging workspace workspace save metrics (`pipeline_64.gtkw`).

## 🚀 How to Run
Compile your Verilog workspace source modules using a hardware description simulator and review the execution tracking clock-by-clock by loading the output trace file directly into **GTKWave**.# RISC-V-64-Bit-Pipelined
