module TemperatureLightPowerController (
    input wire clk,
    input wire rst,
    input wire [7:0] temperature_sensor,  // 8-bit temperature sensor data
    input wire [7:0] light_sensor,        // 8-bit light sensor data
    input wire [8:0] power_monitor,       // 9-bit power usage monitor (0-511 units)
    output wire heater,                   // Heater control signal
    output wire cooler,                   // Cooler control signal
    output wire light,                    // Light control signal
    output wire alarm                     // Alarm control signal
);

// Define some constants for control thresholds
parameter TEMPERATURE_THRESHOLD = 8'b00100000;  // Example temperature threshold (adjust as needed)
parameter LIGHT_THRESHOLD = 8'b00110000;        // Example light threshold (48)
parameter POWER_THRESHOLD = 9'b010100000;       // Example power threshold (160 units)

// Registers for control logic
reg heater_reg, cooler_reg, light_reg, alarm_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        heater_reg <= 1'b0;
        cooler_reg <= 1'b0;
        light_reg <= 1'b0;
        alarm_reg <= 1'b0;
    end else begin
        // Temperature control logic
        if (temperature_sensor > TEMPERATURE_THRESHOLD) begin
            cooler_reg <= 1'b1;
            heater_reg <= 1'b0;
        end else if (temperature_sensor < TEMPERATURE_THRESHOLD) begin
            cooler_reg <= 1'b0;
            heater_reg <= 1'b1;
        end else begin
            cooler_reg <= 1'b0;
            heater_reg <= 1'b0;
        end

        // Light control logic
        if (light_sensor < LIGHT_THRESHOLD) begin
            light_reg <= 1'b1;
        end else begin
            light_reg <= 1'b0;
        end

        // Power usage alarm logic
        if (power_monitor > POWER_THRESHOLD) begin
            alarm_reg <= 1'b1;
        end else begin
            alarm_reg <= 1'b0;
        end
    end
end

assign heater = heater_reg;
assign cooler = cooler_reg;
assign light = light_reg;
assign alarm = alarm_reg;

endmodule
