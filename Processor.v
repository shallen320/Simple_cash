module processor;
  reg clk, reset;   //clock and reset signal
  reg clk_mem;      // slower clock for memory
  reg [23:0]addr;   // address line
  wire [23:0] addr_bufout;  // address line out of address buffer
  reg [7:0]data_in;   // input data
  wire [31:0] data_ram;   //data line between cache and ram
  wire [23:0] addr_ram;   // address line between cache and ram
  reg read, write;  // read write signal
  wire cmplt;     // complete signal, indicating ram read or write complete
  wire [7:0]data; // data line
  wire rd_ram, wrt_ram, wrt_bck, fetch; //control signal output by cache, 
          //indicating read ram, write ram, write back or fetch a block into cache
  wire [7:0]buf_out;  // data line out of data buffer
  
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
 