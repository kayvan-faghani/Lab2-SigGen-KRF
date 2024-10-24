#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc,argv);
    Vsinegen* top = new Vsinegen;
    Verilated:: traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace (tfp,99);
    tfp->open ("sinegen.vcd");

    if(vbdOpen()!=1) return(-1);
    vbdHeader("Lab 2: Counter");

    top->clk = 1;
    top->rst = 0;
    top->en = 1;

    for(i=0;i<10000000;i++){
        for(clk=0;clk<2;clk++){
            top->incr = vbdValue();
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();
        }
        //Right shifts each value 16,8, 4 and 0 respectively
        //This is then anded with F which is 16, to give us the
        //value of count for each digit
        //vbdPlot(int(top->count), 0, 255);
        top->en = vbdFlag();
        vbdPlot(int(top->dout1), 0, 255);
        vbdPlot(int(top->dout2), 0, 255);
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q'))  exit(0); 
    }

    vbdClose();
    tfp->close();
    exit(0);
}