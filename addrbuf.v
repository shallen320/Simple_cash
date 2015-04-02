module addrbuf(addr_in, addr_out, rd_ram, wrt_ram);
  input rd_ram, wrt_ram;
  input [23:0]addr_in;
  output [23:0]addr_out;
  
  assign addr_out=(rd_ram==1 || wrt_ram==1)?addr_in:addr_out;
      
endmodule
