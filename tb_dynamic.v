`include "dynamic_pattern.v"

module tb;


 reg clk, rst, data_in, paddr, pwdata, pwrite, penable, pready;
wire pattern_det;

integer total;

pattern dut (clk, rst, data_in, paddr, pwdata, pwrite, penable, pready,pattern_det);

initial
begin
clk=0;
forever #5 clk = ~clk;
end

initial
begin
    reset();
    test_1();
repeat(10) @(posedge clk);
    $display("number of times detected=%0d",total);

    #100;
    $finish;


end

task reset();
    begin
    rst=1;
    data_in=0;
    paddr=0;
    pwdata=0;
    pwrite=0;
    penable=0;
    pready=0;
    total=0;
    @(posedge clk);
    rst=0;
    end
endtask

task test_1();
    begin
        repeat(600)
    begin
    @(posedge clk);
{paddr, pwdata, pwrite, penable, pready} = $random;
data_in=$random %2;
end
@(posedge clk);

{paddr, pwdata, pwrite, penable, pready} = 0;
data_in=0;



    end
endtask

initial
begin
forever begin 
@(posedge clk);
    if(pattern_det)
        total=total+1;
end

end

endmodule
