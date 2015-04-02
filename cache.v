module cache (clk, reset, data, addr, data_ram, addr_ram, read, write, cmplt, wrt_bck, fetch, rd_ram, wrt_ram);
  inout [7:0] data;   //data
  input [23:0] addr;  //address
  input clk;  //clock
  input read;   // read signal
  input write;  //write signal
  inout [31:0] data_ram;  //data line to ram
  output reg [23:0] addr_ram = 0; // address line to ram
  input reset;
  input cmplt;
  output reg rd_ram, wrt_ram, wrt_bck, fetch;

  reg [31:0] ram [2**14-1:0];  //64KBytes cache
  reg [7:0] tag [2**14-1:0];  //tag memory
  reg update [2**14-1:0];     // this bit is set 1 when a block in cache has changed
  reg [7:0] dataout;
  wire [7:0] datain;
  reg [31:0] data_ram_out;
  wire [31:0] data_ram_in;
  
  
  integer i;
  
  initial begin
    $readmemh("cache.txt",ram);
    $readmemh("tag.txt",tag);
    for (i=0; i<2**14; i=i+1)
      update [i] = 0;     
  end
  
  /*
   *    state machine
   */

  parameter READY = 8'b00000001;   //ready state
  parameter HIT = 8'b00000010;    //hit  (not used in this design)
  parameter MISS = 8'b00000100;   //miss  (not used in this design)
  parameter R_WRT_BCK = 8'b00001000;  //write back when read
  parameter RD_RAM = 8'b00010000;     //read ram
  parameter REPLACE = 8'b00100000;    //replace block
  parameter WRT_RAM = 8'b01000000;    //write ram
  parameter W_WRT_BCK = 8'b10000000;  //write back when write
  reg [7:0] state = READY;
  
   always@(posedge clk)
      if (reset) begin
         state <= READY;
      end
      else
          case (state)
            READY : begin
             if (addr[23:16]==tag[addr[15:2]]) 
              if (read)
                case (addr[1:0])
                  2'b00 : dataout <= ram[addr[15:2]][7:0];
                  2'b01 : dataout <= ram[addr[15:2]][15:8];
                  2'b10 : dataout <= ram[addr[15:2]][23:16];
                  2'b11 : dataout <= ram[addr[15:2]][31:24];
                  default: ;
                endcase
              else if(write) begin
                case (addr[1:0])
                  2'b00 : ram[addr[15:2]][7:0] <= datain;
                  2'b01 : ram[addr[15:2]][15:8] <= datain;
                  2'b10 : ram[addr[15:2]][23:16] <= datain;
                  2'b11 : ram[addr[15:2]][31:24] <= datain;
                  default: ;       
                endcase
                update[addr[15:2]] <= 1;
              end
              else ;               
             else if (read) 
                if (update[addr[15:2]])
                    state <= R_WRT_BCK;
                else if(!update[addr[15:2]])
                    state <= RD_RAM;
                else ;
             else if (write)
                  state <= WRT_RAM;
              rd_ram = 0;
              wrt_ram = 0;
              wrt_bck = 0;
              fetch = 0;
            end
            
            R_WRT_BCK : begin
               if (cmplt == 1)
                  state <= RD_RAM;
               addr_ram = {tag[addr[15:2]], addr[15:2], 2'b00};
               data_ram_out = ram[addr[15:2]];
               wrt_bck = 1;
               update[addr[15:2]] = 0;
            end
            
            RD_RAM : begin
               if (cmplt == 1)
                  state <= REPLACE;
               wrt_bck = 0;   
               rd_ram = 1;
            end
            
            REPLACE : begin
               if (cmplt == 1) begin
                  state <= READY;
               //   fetch <= 0;
               end
               wrt_ram <= 0;
               rd_ram = 0;
               fetch = 1;
               addr_ram = addr;
               ram[addr[15:2]]<=data_ram_in;
               tag[addr[15:2]]<=addr[23:16]; 
            end
           
            WRT_RAM : begin
              if (cmplt == 1) begin
                if (update[addr[15:2]])
                    state <= W_WRT_BCK;
                else if (!update[addr[15:2]])
                    state <= REPLACE;
                else ;
              end
              wrt_ram <= 1;
            end
            
            W_WRT_BCK : begin
               if (cmplt == 1) begin
                  state <= REPLACE;
                  wrt_bck <= 0;
               end
               addr_ram = {tag[addr[15:2]], addr[15:2], 2'b00};
               data_ram_out = ram[addr[15:2]];
               wrt_ram <= 0;
               wrt_bck = 1;
               update[addr[15:2]] = 0;
            end
            
         endcase  
      
  assign data_ram_in = data_ram;
  assign data_ram = wrt_bck?data_ram_out:32'hzzzzzzzz;      
  assign datain = data;
  assign data = read?dataout:8'hzz;

endmodule