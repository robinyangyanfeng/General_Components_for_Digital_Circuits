/* 
 * Created by RobinYang at 27th/Aug/2022
 * This project is that uart module based on AHB protocol,
 * for building System-on-Chip up
 */

module uart2ahb_top #
(
	parameter DATA_WIDTH = 32	,
	parameter ADDR_WIDTH = 32
)
(
	input		wire			hclk		,
	input		wire			hrst_n	,
	
	/*
	 *	AHB input
	 */
	input		wire [ADDR_WIDTH-1:0]		m_haddr_i	,
	input		wire [1:0]							m_htrans_i,
	input		wire										m_hwrite_i,
	input		wire [2:0]							m_hsize_i	,
	input		wire [2:0]							m_hburst_i,
	input		wire [3:0]							m_hprot_i	,
	input		wire [DATA_WIDTH-1:0]		m_hwdata_i,
	
	input		wire										m_hsel_i	,
	
	/*
	 *	AHB output
	 */
	output	wire [DATA_WIDTH-1:0]		s_hrdata_o,
	output	wire 										s_hready_o,
	output	wire [1:0]							s_resp_o	,
	
	/*
	 *	Uart interface
	 */
	input		wire										rxd,
	output	wire										txd,
	
	/*
	 *	Status
	 */
	output	wire										tx_busy,
	output	wire										rx_busy,
	output	wire										rx_overrun_error,
	output	wire										rx_frame_error,
	
	/*
	 *	Configuration
	 */
	input		wire [15:0]							prescale

);

uart_tx #(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
)
uart_tx_inst (

);

uart_rx #(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
)
uart_rx_inst (

);