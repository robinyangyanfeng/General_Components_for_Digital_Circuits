/*
 * This UART transfer module
 */

module uart_tx #
(
		parameter		DATA_WIDTH = 32,
		parameter		ADDR_WIDTH = 32
)
(
		input		wire					clk		,
		input		wire					rst_n	,
		
		/*
		 * AHB input
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
		 * Uart interface
		 */
		output	wire					txd,
		
		/*
		 * Status
		 */
		output	wire					busy,
		
		/*
		 * Configuration
		 */
		input		wire [15:0]		prescale
);

