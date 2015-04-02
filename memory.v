module memory (clk, data, addr, read, write, data_cach, addr_cach, wrt_bck, fetch, cmplt);
  inout [7:0] data;   //data
  inout [31:0] data_cach;
  input [23:0] addr;  //address
  input [23:0] addr_cach; // address line from cache
  input clk;  //clock
  input read;   // read signal
  input write;  //write signal
  input wrt_bck; // write back signal
  input fetch; //fetch block to cash signal
  output reg cmplt = 0; //complete signal indicate read/write complete

  reg [31:0] mem [2**22-1:0];  //16MBytes cache
  reg [31:0] data_cach_out;
  wire [31:0] data_cach_in;
  reg [7:0] dataout;
  wire [7:0] datain;
  
  initial
    $readmemh("mem.txt",mem);
  
  always @(posedge clk)
    if (read) begin
      case (addr[1:0])
        2'b00 : dataout <= mem[addr[23:2]][7:0];
        2'b01 : dataout <= mem[addr[23:2]][15:8];
        2'b10 : dataout <= mem[addr[23:2]][23:16];
        2'b11 : dataout <= mem[addr[23:2]][31:24];
        default: ;
      endcase
      cmplt = 1;
    end
    else if(write) begin
      case (addr[1:0])
        2'b00 : mem[addr[23:2]][7:0] <= datain;
        2'b01 : mem[addr[23:2]][15:8] <= datain;
        2'b10 : mem[addr[23:2]][23:16] <= datain;
        2'b11 : mem[addr[23:2]][31:24] <= datain;
        default: ;       
      endcase
      cmplt = 1;
    end
    else if(wrt_bck) begin
      mem[addr_cach[23:2]] <= data_cach_in;
      cmplt = 1;
    end
    else if(fetch) begin
      data_cach_out <= mem[addr_cach[23:2]];
      cmplt = 1;
    end 
    else
      cmplt = 0;
  
  always @(negedge clk)
    cmplt = 0;
      
  assign data_cach_in = data_cach;
  assign data_cach = fetch?data_cach_out:32'hzzzzzzzz;
  assign datain = data;
  assign data = read?dataout:8'hzz;

endmodule