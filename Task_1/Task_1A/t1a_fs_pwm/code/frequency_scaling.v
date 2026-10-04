module frequency_scaling (
    input clk_50MHz,
    input reset_n,
    output reg clk_5MHz
);

reg [2:0] count;

always @(posedge clk_50MHz or negedge reset_n)
begin
    if (!reset_n)
    begin
        count <= 3'd4;
        clk_5MHz <= 1'b0;
    end
    else
    begin
        if (count == 3'd4)
        begin
            count <= 3'd0;
            clk_5MHz <= ~clk_5MHz;
        end
        else
        begin
            count <= count + 3'd1;
        end
    end
end

endmodule
