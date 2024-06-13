module ibex_main (
	// Inputs
	RSTsys, 
	CLK,  
	RDY, RDYOUT, READDAT, RESP, 
	// Outputs
    	TRF, SIZE, DIR, BRSTsz, 
	WRITE, DATW, 
);
	//----------------------------------------------------------------------------
	// Port declarations
	//----------------------------------------------------------------------------
	
	input reg          RSTsys;            // Reset sistema
	input          CLK;               // System clock
	
	// Puertos del maestro
	input          RDYOUT;          // Bus RDY
	input   [31:0] READDAT;             // Bus lectura dat
	
	// Outputs
	output   [1:0]  TRF;            // Tipo transferencia bus
	output   [2:0]  SIZE;             // Tamaño de transferencia bus
	output   [31:0] DIR;             // Dirección bus
	output   [2:0]  BRSTsz;            // Tamaño burst
	
	output          WRITE;            // Escritura bus
	output  [31:0]  DATW;            //Datos escritura

	output RDY;

	//----------------------------------------------------------------------------
	// IBEX declarations
	//----------------------------------------------------------------------------
    wire          test_en_i;     // habilitamos todas las puertas para el test
    wire   [31:0] hart_id_i;
    wire   [31:0] boot_dir_i;
    // Instruction memory interface
    wire         pet_inst_o;
    wire          instr_gnt_i;
    wire          instr_rvalid_i;
    wire  [31:0] instr_dir_o;
    wire   [31:0] instr_readdat_i;
    wire          instr_err_i;
    // Data memory interface
    wire         pet_dat_o;
    wire          data_gnt_i;
    wire          data_rvalid_i;
    wire         data_we_o;
    wire  [3:0]  data_be_o;
    wire  [31:0] data_dir_o;
    wire  [31:0] data_datw_o;
    wire   [31:0] data_readdat_i;
    wire          data_err_i;
    // Interrupt inputs
    wire          irq_software_i;
    wire          irq_timer_i;
    wire          irq_external_i;
    wire   [14:0] irq_fast_i;
    wire          irq_nm_i;       

    // Debug Interface
    wire          debug_req_i;

	ibex_core ic (

		CLK,
		RSTsys,
		test_en_i,

		hart_id_i,
		boot_dir_i,

		pet_inst_o,
		instr_gnt_i,
		instr_rvalid_i,
		instr_dir_o,
		instr_readdat_i,
		instr_err_i,

		pet_dat_o,
		data_gnt_i,
		data_rvalid_i,
		data_we_o,
		data_be_o,
		data_dir_o,
		data_datw_o,
		data_readdat_i,
		data_err_i,

		irq_software_i,
		irq_timer_i,
		irq_external_i,
		irq_fast_i,
		irq_nm_i,

		debug_req_i,
		
		fetch_enable_i,
		alert_minor_o,
		alert_major_o,
		core_sleep_o
);

ibex_interface interface  (

	clk_i,
	rst_ni,

	pet_inst_o,
	instr_rvalid_i,
	instr_dir_o,
	instr_readdat_i,

	pet_dat_o,
	data_rvalid_i,
	data_we_o,
	data_be_o,
	data_dir_o,
	data_datw_o,
	data_readdat_i,

	instr_gnt_i,
	data_gnt_i,

	TRF,            // Tipo transferencia bus
	SIZE,             // Tamaño de transferencia bus  
	DIR,             // Dirección bus
	BRSTsz,            // Tamaño burst
	WRITE,            // Escritura bus
	DATW,            // Datos escritura
	READDAT,		  // Lectura del bus

	RDY			    	//parada

);
endmodule
