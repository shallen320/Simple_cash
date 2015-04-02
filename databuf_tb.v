module databuf_tb;
  reg rd_ram, wrt_ram;
  wire [7:0] data_in;
  wire [7:0] data_out;
  
  reg [7:0] data_in_in;
  reg [7:0] data_out_in;
  
  databuf D1 ( data_in, data_out, rd_ram, wrt_ram);
  
  assign data_in=wrt_ram?data_in_in:8'hzz;
  assign data_out=rd_ram?data_out_in:8'hzz;
  
  initial begin
    data_in_in = 8'h23;
    data_out_in = 8'h44;
    rd_ram =0;
    wrt_ram =0;
    #10 wrt_ram = 1;
    #10 wrt_ram = 0;
    #30 rd_ram = 1;
    #10 rd_ram = 0;
  end
endmodule
