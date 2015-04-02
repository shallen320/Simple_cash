module cache_tb;
  reg clk, reset, cmplt;
  reg [23:0]addr;
  reg [7:0]data_in;
  reg [31:0] data_ram_in;
  wire [31:0] data_ram;
  wire [23:0] addr_ram;
  reg read, write;
  wire [7:0]data;
  wire rd_ram, wrt_ram, wrt_bck, fetch;
  
  
  assign data_ram=fetch?data_ram_in:32'hzzzz;
  assign data=write?data_in:8'hzz;
  cache C1 (clk, reset, data, addr, data_ram, addr_ram, read, write, cmplt, wrt_bck, fetch, rd_ram, wrt_ram);
  
  initial begin
    clk = 0;
    addr = 24'h000003;
    read = 0;
    write = 0;
    cmplt = 0;
    #10 read = 1;     //read addr h003
    #10 read = 0;
    #10 write = 1; data_in=8'h56; // write h56 to addr h003
    #10 write = 0; data_in=0;
    #10 read = 1;    //read addr h003
    #10 read = 1;  addr = 24'h010000;  //read addr h10000, which will lead to a write back
    #10 read = 0;
    #30 cmplt = 1;      //write back complete
    #10 cmplt = 0;
    #20 cmplt = 1;      //read complete
    #10 cmplt = 0;
    #10 data_ram_in = 32'h66666666;
    #10 cmplt = 1;      //replace complete
    #10 cmplt = 0;   addr = 24'h000006;
    #10 write = 1; data_in=8'h33; //write data h33 to addr h06, this will change the update bit
    #10 write = 0; data_in = 8'h55; addr = 24'h020007;  
    #10 write = 1; //write data 8'h55 to addr h020007, this will cause a write back
    #10 write = 0;
    #20 cmplt = 1;  // write to ram complete
    #10 cmplt = 0;
    #20 cmplt = 1;
    #10 cmplt = 0;  // write back complete
    #10 data_ram_in = 32'h55bcbcbc;  //fetch 32'h55bcbcbc from memory
    #20 cmplt = 1;  //fetch complete
    #10 cmplt = 0;
     
  end
  
    
    
 	initial        //generate clock
    clk=0; //initial clock as 0
  always
    #5 clk=~clk;    
    
endmodule
    