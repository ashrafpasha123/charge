# charge
 Asynchronous FIFO Design and Verification – Milestone 1

This project implements the core components of an Asynchronous FIFO system in Verilog. Milestone 1 includes the design and verification of:

Dual-Port Memory Module
2 Flip-Flop Synchronizer
Basic Testbenches for both components
Module Descriptions
 dual_port_ram.v

A dual-port RAM that supports simultaneous read/write access from two different clock domains (clk_a and clk_b).
 sync_2ff.v
A 2-stage flip-flop synchronizer used to transfer control signals safely between asynchronous clock domains.
