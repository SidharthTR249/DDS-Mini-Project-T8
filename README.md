# DDS-Mini-Project-T8

SMART HOME ENERGY MONITORING & MANAGEMENT SYSTEM
Team members:
1. 221CS208 , Ankur Jat , ankurjat.221cs208@nitk.edu.in , 8000950925.
2. 221CS244 , Sandeep R , sandeepr.221cs244@nitk.edu.in , 8105090281.
3. 221CS249 , Sidharth T R , sidharthtr.221cs249@nitk.edu.in , 8590383683.
   
 ABSTRACT
 
The Smart Home Energy Monitoring and Management System is a solution designed to tackle the increasing demand, for energy efficiency and sustainability in areas. With the rising number of devices and a growing
awareness of impact it has become crucial to have an integrated system that empowers homeowners to effectively monitor, control and optimize their energy usage. Moreover, We can make many houses power usage
under 200 unit. So, that the can avail the Gruha Jyothi Scheme introduced by The Karnataka Government.

FUNCTIONS

Introduction:
The Smart Home Energy Monitoring and Control System is an innovative project that demonstrates the capabilities of Verilog-based hardware design to create an energy-efficient and comfortable home
environment. This comprehensive system combines several Verilog modules, each serving a specific function, to monitor energy consumption, manage power usage, control lighting, and maintain
temperature within predefined thresholds which can help the people to maintain their power usage under 200 units from which they can avail free electricity introduced by the Government of Karnataka. The
integration of these modules showcases the power of hardware modules working together to create a cohesive and intelligent smart home solution.

I. Energy Monitoring and Management:

At the heart of the project lies the Smart Home Energy Monitoring and Management System, which incorporates various modules to monitor, control, and optimize energy usage. The Verilog code represents these
modules and processes data from sensors to provide real-time information on energy consumption. The functional table outlines key components and features, including user interfaces, appliance-level
monitoring, energy usage alerts, remote control, energy management recommendations, integration with smart devices, energy cost analysis, history, and reports, as well as security and privacy
measures. This holistic system empowers homeowners to make informed decisions to reduce energy waste and lower utility bills effectively.

II. Power Usage Alarm:

An essential element of the project is the Power Usage Alarm module, which triggers an alarm when power usage exceeds a predefined threshold of 150 units. This Verilog module continuously monitors the
power usage input and activates an alarm signal when the threshold is breached. This feature serves as a practical tool to notify homeowners of excessive power consumption promptly, encouraging
energy-conscious behavior.

III. Temperature Control:

The Temperature Control module is designed to maintain a comfortable temperature within the home while conserving energy. Operating within a state machine framework, the Verilog code defines
three states: START, HEATER_ON, and AC_ON. Based on input from a temperature sensor, the system activates the heater when the temperature falls below 50°F and the air conditioner when it exceeds
70°F. If the temperature is within this range or equals either 50°F or 70°F, no action is taken, and the system remains in the START state. This intelligent control system ensures optimal temperature
conditions while minimizing energy consumption.

IV. Power Usage Counter:

The project also includes a Power Usage Counter module, which tracks the total power usage over time. This Verilog module utilizes a counter to accumulate power usage data and increments it when the
predefined threshold is exceeded. It offers homeowners valuable insights into their long-term power consumption patterns, facilitating better management and conservation of energy resources.

V. Light Control State Machine:

The Light Control State Machine is a sophisticated Verilog module that manages lighting based on ambient conditions. It monitors light intensity through sensors and, using a state machine, determines
whether to increase or decrease the current through the light source. When light intensity falls below a specified threshold, the system increases the current, providing adequate illumination. Conversely,
when light intensity surpasses another threshold, the system decreases the current to conserve energy. This intelligent lighting control system ensures a well-lit environment while minimizing energy
waste.


LOGISIM
![Screenshot (39)](https://github.com/SidharthTR249/DDS-Mini-Project-T8/assets/148998611/6ed3744c-5a78-43d7-9469-34e8b5bdffe1)

![Screenshot (43)](https://github.com/SidharthTR249/DDS-Mini-Project-T8/assets/148998611/8e8879c8-e725-45fe-b8b8-c32f7cc73877)
![WhatsApp Image 2023-10-25 at 8 31 56 PM (1)](https://github.com/SidharthTR249/DDS-Mini-Project-T8/assets/148998611/57c35849-f4ba-45ee-8edc-70c68aa086d5)
![WhatsApp Image 2023-10-25 at 8 31 56 PM (2)](https://github.com/SidharthTR249/DDS-Mini-Project-T8/assets/148998611/c6efa3c7-2f19-47f3-8075-e3b728812fd4)
![WhatsApp Image 2023-10-25 at 8 31 57 PM](https://github.com/SidharthTR249/DDS-Mini-Project-T8/assets/148998611/3b9997f1-6bd1-4f8a-96f4-b540e7a7d0ee)



VERILOG CODE

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

TEST BENCH
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

SNAPSHOT OF VERILOG
![Screenshot (41)](https://github.com/SidharthTR249/DDS-Mini-Project-T8/assets/148998611/25b50ff8-079c-46a7-bf3c-e34b4a975c55)


