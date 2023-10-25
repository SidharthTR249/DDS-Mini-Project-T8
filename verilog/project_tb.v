module TemperatureLightPowerController_tb;

reg clk;
reg rst;
reg [7:0] temperature_sensor;
reg [7:0] light_sensor;
reg [8:0] power_monitor;
wire heater;
wire cooler;
wire light;
wire alarm;

// Instantiate the controller module
TemperatureLightPowerController uut (
    .clk(clk),
    .rst(rst),
    .temperature_sensor(temperature_sensor),
    .light_sensor(light_sensor),
    .power_monitor(power_monitor),
    .heater(heater),
    .cooler(cooler),
    .light(light),
    .alarm(alarm)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    rst = 1;
    temperature_sensor = 8'b00000000;
    light_sensor = 8'b00000000;
    power_monitor = 9'b000000000;
    #10 rst = 0;

    // Monitor the control signals
    $monitor("Time=%0t: Temp=%d Light=%d Power=%d Heater=%b Cooler=%b Light=%b Alarm=%b",
             $time, temperature_sensor, light_sensor, power_monitor, heater, cooler, light, alarm);

    // Simulate temperature, light, and power data changes
    #10 temperature_sensor = 8'b01010101; // Example: 85 (adjust as needed)
    #10 light_sensor = 8'b00110011;       // Example: 51 (adjust as needed)
    #10 power_monitor = 9'b101000001;    // Example: 321 (adjust as needed)

    // Add more test scenarios as needed

    #1000 $finish;
end

endmodule
