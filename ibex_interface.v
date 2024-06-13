module ibex_interface (

    input wire  clk_i,
	input wire  rst_ni,

	input wire  pet_inst_o,
	input wire  instr_rvalid_i,
	input wire  [31:0] instr_dir_o,
	input wire  [31:0] instr_readdat_i,

	input wire  pet_dat_o,
	input wire  data_rvalid_i,
	input wire  data_we_o,
	input wire  [3:0] data_be_o,
	input wire  [31:0] data_dir_o,
	input wire  [31:0] data_datw_o,
	input wire  [31:0] data_readdat_i,

    output wire  instr_gnt_i,
    output wire  data_gnt_i,

    output wire   [1:0]  TRF,            // Tipo transferencia bus
    output wire   [2:0]  SIZE_out,         // Tamaño de transferencia bus  
    output wire   [31:0] DIR_out,         // Dirección bus
    output wire   [2:0]  BRSTsz,            // Tamaño burst
    output wire          WRITE,            // Escritura bus
    output wire  [31:0]  DATW,            //Datos escritura
    output wire  [31:0]  READDAT,		   //Datos lectura

    input  wire     RDY			    	//  parada


);

reg [31:0] DIR;
reg [2:0] SIZE;
reg RDY_T;

reg instr_gnt_t;
reg data_gnt_t;

assign TRF = 2'b10;                      //no secuandial
assign BRSTsz = 3'b000;                     //Acceso único

assign DATW = data_datw_o;
assign READDAT = data_readdat_i;

assign WRITE = data_we_o;
      
//  Arbitraje Instru-Datos, prioridad a las Instrucciones

reg counter;

always @(posedge clk_i) begin

    counter = ~counter;
    
end


always @(posedge clk_i or negedge rst_ni)

    if (!rst_ni) begin //si reset activo a nivel bajo
        counter = 1'b0; //contador a cero
    end

    else 
    begin

		if (pet_inst_o && !pet_dat_o )   // Pide instrucción -- NO pide datos
			begin                          // proceso petición intrucción

                DIR = instr_dir_o;
                SIZE = 3'b010;            
                data_gnt_t = 1'b0; 

                instr_gnt_t = 1'b1;         // señalizamos que la petición ha sido tramitada

                RDY_T = RDY;

            end

        else if (pet_inst_o && pet_dat_o )     // Pide instrucción & Pide datos
			begin                           // proceso petición intrucción

           

                DIR = instr_dir_o;
                SIZE = 3'b010;           

                instr_gnt_t = 1'b1 ;        // señalizamos que la petición ha sido tramitada
                data_gnt_t = 1'b0;          


                RDY_T = RDY;

            end

        else if (!pet_inst_o && pet_dat_o )     // NO pide instrucción -- Pide datos
			begin                           // proceso petición datos


         

                DIR = data_dir_o;
                SIZE = 3'b010;         

                data_gnt_t = 1'b1 ;         // señalizamos que la petición ha sido tramitada
                instr_gnt_t = 1'b0;         
                RDY_T = RDY;

            end
        else begin				// NO pide instrucción -- NO pide datos
            
                DIR = instr_dir_o;
                SIZE = 3'b010;            

                instr_gnt_t = 1'b0;         
                data_gnt_t = 1'b0; 

                RDY_T = RDY;      
        end
    end

    assign RDY = RDY_T;
    assign DIR_out = DIR;
    assign RDY = RDY_T;
    assign SIZE_out = SIZE;

    assign instr_gnt_i = instr_gnt_t;
    assign data_gnt_i = data_gnt_t;


endmodule
