module cach_mem_tb;
  reg clk, reset;
  reg clk_mem;
  reg [23:0]addr;
  wire [23:0] addr_bufout;
  reg [7:0]data_in;
  wire [31:0] data_ram;
  wire [23:0] addr_ram;
  reg read, write;
  wire cmplt;
  wire [7:0]data;
  wire rd_ram, wrt_ram, wrt_bck, fetch;
  wire [7:0]buf_out;
  
  assign data=write?data_in:8'hzz;
  
  cache C1 (clk, reset, data, addr, data_ram, addr_ram, read, write, cmplt, wrt_bck, fetch, rd_ram, wrt_ram);
  memory M1 (clk_mem, buf_out, addr_bufout, rd_ram, wrt_ram, data_ram, addr_ram, wrt_bck, fetch, cmplt);
  databuf D1 (data, buf_out, rd_ram, write);
  addrbuf A1 (addr, addr_bufout, read, write);
  
  initial begin
    reset = 0; 
    clk = 0;
    clk_mem =0;
    addr = 24'h000003;
    data_in = 0;
    read = 0;
    write = 0;
    #10 read = 1;     //read addr h003
    #10 read = 0;
    #10 write = 1; data_in=8'h56; // write h56 to addr h003
    #10 write = 0; data_in=0;
    #10 read = 1;    //read addr h003
    
#10 read = 1;  addr = 24'h010000;  //read addr h10000, which will lead to a write back
    #10 read = 0;     //takes 80ns to complete
    #75 addr = 24'h000006;
    #5 write = 1; data_in = 8'h33; //write data h33 to addr h06, this will change the update bit
    #10 write =0; data_in = 8'h55; addr = 24'h020007;
    #10 write = 1; //write data 8'h55 to addr h020007, this will cause a write back
    #10 write = 0;
    
  end
  
  always
    #5 clk=~clk;  //clock for cache
  
  always
    #10 clk_mem=~clk_mem;
    
  endmodule 
        