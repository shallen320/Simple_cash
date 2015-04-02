module databuf( data_in, data_out, rd_ram, wrt_ram);
  input rd_ram, wrt_ram;
  inout [7:0]data_in;
  reg [7:0] data_buf;
  inout [7:0]data_out;
  
  always @ (posedge wrt_ram)
    data_buf = data_in;
  
  
   
  assign data_out = (!rd_ram)?data_buf:8'hzz;
  assign data_in = rd_ram?data_out:8'hzz;
      
endmodule
