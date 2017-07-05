
`include "apb_bus.sv"

module periph_bus_wrap0
  #(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
    )
   (
    input logic       clk_i,
    input logic       rst_ni,

    APB_BUS.Slave     apb_slave,

    APB_BUS.Master    uart_master,
    APB_BUS.Master    gpio_master,
    APB_BUS.Master    spi_master,
    APB_BUS.Master    timer_master,
    APB_BUS.Master    event_unit_master,
    APB_BUS.Master    i2c_master,
    APB_BUS.Master    soc_ctrl_master,
    APB_BUS.Master    debug_master,
    APB_BUS.Master    pwm_master

    );

  localparam NB_MASTER      = `NB_MASTER0;

  logic [NB_MASTER-1:0][APB_ADDR_WIDTH-1:0] s_start_addr;
  logic [NB_MASTER-1:0][APB_ADDR_WIDTH-1:0] s_end_addr;

  APB_BUS
    #(
      .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
      .APB_DATA_WIDTH(APB_DATA_WIDTH)
      )
  s_masters[NB_MASTER-1:0]();

  APB_BUS
    #(
      .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
      .APB_DATA_WIDTH(APB_DATA_WIDTH)
      )
  s_slave();

  `APB_ASSIGN_SLAVE(s_slave, apb_slave);

  `APB_ASSIGN_MASTER(s_masters[0], uart_master);
  assign s_start_addr[0] = `UART_START_ADDR;
  assign s_end_addr[0]   = `UART_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[1], gpio_master);
  assign s_start_addr[1] = `GPIO_START_ADDR;
  assign s_end_addr[1]   = `GPIO_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[2], spi_master);
  assign s_start_addr[2] = `SPI_START_ADDR;
  assign s_end_addr[2]   = `SPI_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[3], timer_master);
  assign s_start_addr[3] = `TIMER_START_ADDR;
  assign s_end_addr[3]   = `TIMER_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[4], event_unit_master);
  assign s_start_addr[4] = `EVENT_UNIT_START_ADDR;
  assign s_end_addr[4]   = `EVENT_UNIT_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[5], i2c_master);
  assign s_start_addr[5] = `I2C_START_ADDR;
  assign s_end_addr[5]   = `I2C_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[6], soc_ctrl_master);
  assign s_start_addr[6] = `SOC_CTRL_START_ADDR;
  assign s_end_addr[6]   = `SOC_CTRL_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[7], debug_master);
  assign s_start_addr[7] = `DEBUG_START_ADDR;
  assign s_end_addr[7]   = `DEBUG_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[8], pwm_master);
  assign s_start_addr[8] = `PWM_START_ADDR;
  assign s_end_addr[8]   = `PWM_END_ADDR;

  //********************************************************
  //**************** SOC BUS *******************************
  //********************************************************

  apb_node_wrap
  #(
    .NB_MASTER      ( NB_MASTER      ),
    .APB_ADDR_WIDTH ( APB_ADDR_WIDTH ),
    .APB_DATA_WIDTH ( APB_DATA_WIDTH )
  )
  apb_node_wrap0_i
  (
    .clk_i        ( clk_i        ),
    .rst_ni       ( rst_ni       ),

    .apb_slave    ( s_slave      ),
    .apb_masters  ( s_masters    ),

    .start_addr_i ( s_start_addr ),
    .end_addr_i   ( s_end_addr   )
  );

endmodule
