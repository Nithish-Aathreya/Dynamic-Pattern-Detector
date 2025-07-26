module pattern(clk,rst,data_in,pattern_det);
input clk,rst,data_in;
output reg pattern_det;

parameter s_rst=5'b00001;
parameter s_a=5'b00010;
parameter s_b=5'b00100;
parameter s_c=5'b01000;
parameter s_d=5'b10000;

reg[4:0]state,n_state;

always@(posedge clk)
begin
if(rst)
begin
pattern_det=0;
state<=s_rst;
n_state<=s_rst;
end

else
begin
    pattern_det=0;
    case(state)
        s_rst:begin
            if(data_in==1)
                n_state<=s_a;
            else
                n_state<=s_rst;
        end
        s_a:begin
            if(data_in==0)
                n_state<=s_b;
            else
                n_state<=s_a;
        end
        s_b:begin
            if(data_in==1)
                n_state<=s_c;
            else
                n_state<=s_rst;
        end
        s_c:begin
            if(data_in==1)
                n_state<=s_d;
            else
                n_state<=s_b;
        end
        s_d:begin
            if(data_in==0) begin
                n_state<=s_b;
                pattern_det=1;
            end
            else
                n_state<=s_a;
        end
    endcase
end
end

always@(n_state)
    state=n_state;
endmodule
