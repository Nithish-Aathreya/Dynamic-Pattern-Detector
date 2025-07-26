module pattern(clk, rst, data_in, paddr, pwdata, pwrite, penable, pready,pattern_det);

input clk, rst, data_in, paddr, pwdata, pwrite, penable, pready;
output reg pattern_det;

reg[4:0]collect;
reg[4:0]pattern;
integer count;


always@(posedge clk)
begin
if(rst)
begin
pattern_det=0;
collect=0;
pattern=0;
count=0;
end

else
begin
pattern_det=0;
pattern = {paddr, pwdata, pwrite, penable, pready};

collect = {collect[3:0],data_in};
count = count+1;
if(count==5)
begin
    if(pattern == collect) begin
    pattern_det=1;
    count=0;
    end
    else
    begin
    pattern_det=0;
    count=count-1;

    end

end


end
end
endmodule

