module pwm_generator(
    input clk_5MHz,
    input reset_n,
    input [4:0] pulse_width,
    output reg clk_500Hz,
    output reg pwm_signal
);

reg [13:0] clk_count;
reg [13:0] pwm_count;

always @(posedge clk_5MHz or negedge reset_n)
begin
    if (!reset_n)
    begin
        clk_count  <= 14'd4999;
        pwm_count  <= 14'd0;
        clk_500Hz  <= 1'b0;
        pwm_signal <= 1'b0;
    end
    else
    begin

        // 5 MHz -> 500 Hz
        // Toggle every 5000 cycles
        if (clk_count == 14'd4999)
        begin
            clk_count <= 14'd0;
            clk_500Hz <= ~clk_500Hz;
        end
        else
        begin
            clk_count <= clk_count + 14'd1;
        end


        // 500 Hz PWM
        // Period = 10000 cycles of 5 MHz = 2 ms

        if (pwm_count == 14'd9999)
        begin
            pwm_count <= 14'd0;
        end
        else
        begin
            pwm_count <= pwm_count + 14'd1;
        end


        // 20 levels:
        // 1 level = 500 clock cycles

        if (pwm_count < (pulse_width * 14'd500))
            pwm_signal <= 1'b1;
        else
            pwm_signal <= 1'b0;

    end
end

endmodule
