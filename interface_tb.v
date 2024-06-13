module ibexb_testbench();

    reg  clk_i;
    reg  rst_ni;

    reg  pet_inst_o;
    reg  instr_rvalid_i;
    reg  [31:0] instr_dir_o;
    reg  [31:0] instr_readdat_i;

    reg  pet_dat_o;
    reg  data_rvalid_i;
    reg  data_we_o;
    reg  [3:0] data_be_o;
    reg  [31:0] data_dir_o;
    reg  [31:0] data_datw_o;
    reg  [31:0] data_readdat_i;
    reg     RDY;			    	// parada
    
    wire  instr_gnt_i;
    wire data_gnt_i;
    wire   [1:0] TRF;            // Tipo transferencia bus
    wire   [2:0]  SIZE_out;            // Tamaño de transferencia bus
    wire   [31:0] DIR_out;           // Dirección bus
    wire   [2:0]  BRSTsz;             // Tamaño burst
    wire          WRITE;              // Escritura de bus
    wire  [31:0]  DATW;               //Datos escritura
    wire  [31:0]  READDAT;			    //Lectura de bus

initial begin 
    clk_i = 1'b0;

    forever begin
    #10 clk_i = ~clk_i;
    end

end

initial begin
$dumpfile("ibex.vcd"); // vcd dump file
$dumpvars; // dump everything
end

initial begin
  rst_ni = 1'b0; 
  
   #10
  pet_inst_o = 1'b1;
  instr_dir_o = 32'h4;
  pet_dat_o = 1'b0;
  data_we_o = 1'b0;
  data_be_o = 4'b0;
  data_dir_o = 32'b0;
  data_datw_o = 32'b0;
  RDY = 1'b1; 

  #20
  rst_ni = 1'b1;
  pet_inst_o = 1'b1;
  pet_dat_o = 1'b1;
  
  instr_dir_o = 32'h4;
  data_dir_o = 32'h6;

  data_we_o = 1'b0;
  data_be_o = 4'b0;

  data_datw_o = 32'b0;
  RDY = 1'b1;

  
  #30
  rst_ni = 1'b1;
  pet_inst_o = 1'b0;
  pet_dat_o = 1'b1;
  
  instr_dir_o = 32'h4;
  data_dir_o = 32'h6;

  data_we_o = 1'b0;
  data_be_o = 4'b0;

  data_datw_o = 32'b0;
  RDY = 1'b1;

    #40
  rst_ni = 1'b1;
  pet_inst_o = 1'b0;
  pet_dat_o = 1'b0;
  
  instr_dir_o = 32'h4;
  data_dir_o = 32'h6;

  data_we_o = 1'b0;
  data_be_o = 4'b0;

  data_datw_o = 32'b0;
  RDY = 1'b1;

	    

end

ibex_interface  uut(
    .clk_i (clk_i),
	.rst_ni (rst_ni),

	.pet_inst_o (pet_inst_o),
    .instr_rvalid_i (instr_rvalid_i),
	.instr_dir_o (instr_dir_o),
    .instr_readdat_i (instr_readdat_i),
	.pet_dat_o (pet_dat_o),
    .data_rvalid_i (data_rvalid_i),
	.data_we_o (data_we_o),
    .data_be_o (data_be_o),
	.data_dir_o (data_dir_o),
	.data_datw_o (data_datw_o),
	.data_readdat_i (data_readdat_i),

    .instr_gnt_i (instr_gnt_i),
    .data_gnt_i (data_gnt_i),

    .TRF (TRF),               // Tipo transferencia bus
    .SIZE_out (SIZE_out),         // Tamaño de transferencia bus 
    .DIR_out (DIR_out),         // Dirección bus
    .BRSTsz (BRSTsz),               // Tamaño burst
    .WRITE (WRITE),               // Escritura de bus
    .DATW (DATW),               //Datos escritura
    .READDAT (READDAT),		      	// Lectura de bus

    .RDY	(RDY)		    	// parada

); 

endmodule
