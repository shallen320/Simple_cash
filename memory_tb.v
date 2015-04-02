module memory_tb;
  wire [7:0] data;   //data
  reg [7:0] data_in;
  wire [31:0] data_cach;
  reg [31:0] data_cach_in;
  reg [23:0] addr;  //address
  reg [23:0] addr_cach; // address line from cache
  reg clk;  //clock
  reg read;   // read signal
  reg write;  //write signal
  reg wrt_bck; // write back signal
  reg fetch; //fetch block to cash signal
  wire cmplt; //complete signal indicate read/write complete
  
  assign data=write?data_in:8'hzz;
  assign data_cach=wrt_bck?data_cach_in:32'hzzzzzzzz;
  
  memory M1 (clk, data, addr, read, write, data_cach, addr_cach, wrt_bck, fetch, cmplt);
  
  initial begin
    data_in = 8'h00;
    data_cach_in = 32'h00000000;
    addr = 24'h000002;
    addr_cach = 24'h000004;
    clk = 0;
    read = 0;
    write = 0;
    wrt_bck = 0;
    fetch = 0;
    #10 read = 1;   // read a byte from addr h02
    #10 read = 0;   addr = 24'h000003;
    #10 write = 1;  data_in = 8'h44;
    #10 write = 0;  // write h44 to addr h03 
    #10 read =1;  //then read addr h03
    #10 read =0;  
    #10 fetch = 1;
    #10 fetch = 0; addr_cach = 24'h0c; data_cach_in = 32'h34343434;
    #10 wrt_bck = 1;// write 32'h34343434 to block at addr 24'h0c
    #10 wrt_bck = 0;
    #10 fetch = 1; //then read the block from addr 24'h0c
    #10 fetch = 0;
  end
  
  initial        //generate clock
    clk=0; //initial clock as 0
  always
    #5 clk=~clk;    
endmodule