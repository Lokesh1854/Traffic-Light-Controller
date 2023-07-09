`timescale 1ms/1ms                          //  timescale to be set, as we are using 50Hz clock frequency (20ms)
`include "traffic_light_controller.v"       //  including file containing design to te be tested

module tb_traffic_light_controller;         //  dummy for testbench
    
    reg clk, rst_bar, sensor;                   //  inputs are given reg datatype
    wire [2:0]  highway_light, country_light;   //  outputs are given wire datatype

    //  initialising the module

    traffic_light_controller DUT(                                  
    .sensor (sensor), .clk (clk), .rst_bar (rst_bar),
    .highway_light(highway_light), .country_light (country_light)   
    );

    localparam CLK_PERIOD = 20;             //  clock with timeperiod 20ms
    always #(CLK_PERIOD/2) clk=~clk;       

    initial begin
        $dumpfile("tb_traffic_light_controller.vcd");               //  dumping file for gtkwave
        $dumpvars(0,tb_traffic_light_controller);                   //  variables to be dumped
        $monitor($time," sensor = %b, rst_bar = %b, highway_light = %b, country_light = %b",sensor,rst_bar,highway_light,country_light);
    end

    initial begin               //  initialising the reg type variables at t = 0
        rst_bar = 0;    
        sensor  = 0;
        clk     = 0;
    end

    initial begin                   //  handles rst_bar for simulation
        #1e3    rst_bar = 1;        //  t = 1  sec
        #479e3  rst_bar = 0;        //  t = 480 sec
        #1e3    rst_bar = 1;        //  t = 481 sec
    end

    initial begin                   //  handles sensor for simulation
        #70e3    sensor = 1;        //  t = 70  sec
        #236e3   sensor = 0;        //  t = 306 sec
        #155e3   sensor = 1;        //  t = 461 sec
        #149e3   sensor = 0;        //  t = 610 sec   (In this case the sensor value will be 1 from 298 to 300 sec when HGCR and therefore at 418 sec HGCR --> HYCR)

    end

    initial begin                   //  finish the simulation / exit
        #650e3  $finish;            //  finishes at t = 650 sec
    end
    
endmodule