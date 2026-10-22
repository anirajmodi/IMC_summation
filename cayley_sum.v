module cayley_sum #(
    parameter W    = 5,
    parameter RESW = 12
)(
    input  wire            clk,
    input  wire            rst,
    input  wire [W-1:0]    l1, l2, l3, l4, l5, l6,
    input  wire [W-1:0]    i1v, i2v, i3v,
    output wire [RESW-1:0] result,
    output wire            root_active
);
    wire ls1, ls2, ls3, ls4, ls5, ls6;
    wire lst1, lst2, lst3, lst4, lst5, lst6;
    node #(.MEMW(W), .IS_ROOT(0), .START0(1)) L1 (
        .clk(clk), .rst(rst), .init_data(l1),
        .l_in(1'b0), .r_in(1'b0), .s_in(1'b0),
        .l_start(1'b0), .r_start(1'b0), .s_start(1'b0),
        .state(ls1), .start_out(lst1), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(1)) L2 (
        .clk(clk), .rst(rst), .init_data(l2),
        .l_in(1'b0), .r_in(1'b0), .s_in(1'b0),
        .l_start(1'b0), .r_start(1'b0), .s_start(1'b0),
        .state(ls2), .start_out(lst2), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(1)) L3 (
        .clk(clk), .rst(rst), .init_data(l3),
        .l_in(1'b0), .r_in(1'b0), .s_in(1'b0),
        .l_start(1'b0), .r_start(1'b0), .s_start(1'b0),
        .state(ls3), .start_out(lst3), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(1)) L4 (
        .clk(clk), .rst(rst), .init_data(l4),
        .l_in(1'b0), .r_in(1'b0), .s_in(1'b0),
        .l_start(1'b0), .r_start(1'b0), .s_start(1'b0),
        .state(ls4), .start_out(lst4), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(1)) L5 (
        .clk(clk), .rst(rst), .init_data(l5),
        .l_in(1'b0), .r_in(1'b0), .s_in(1'b0),
        .l_start(1'b0), .r_start(1'b0), .s_start(1'b0),
        .state(ls5), .start_out(lst5), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(1)) L6 (
        .clk(clk), .rst(rst), .init_data(l6),
        .l_in(1'b0), .r_in(1'b0), .s_in(1'b0),
        .l_start(1'b0), .r_start(1'b0), .s_start(1'b0),
        .state(ls6), .start_out(lst6), .mem_out());

    wire is1, is2, is3;
    wire ist1, ist2, ist3;
    node #(.MEMW(W), .IS_ROOT(0), .START0(0)) I1 (
        .clk(clk), .rst(rst), .init_data(i1v),
        .l_in(ls1), .r_in(ls2), .s_in(1'b0),
        .l_start(lst1), .r_start(lst2), .s_start(1'b0),
        .state(is1), .start_out(ist1), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(0)) I2 (
        .clk(clk), .rst(rst), .init_data(i2v),
        .l_in(ls3), .r_in(ls4), .s_in(1'b0),
        .l_start(lst3), .r_start(lst4), .s_start(1'b0),
        .state(is2), .start_out(ist2), .mem_out());
    node #(.MEMW(W), .IS_ROOT(0), .START0(0)) I3 (
        .clk(clk), .rst(rst), .init_data(i3v),
        .l_in(ls5), .r_in(ls6), .s_in(1'b0),
        .l_start(lst5), .r_start(lst6), .s_start(1'b0),
        .state(is3), .start_out(ist3), .mem_out());

    wire root_st, root_start;
    node #(.MEMW(RESW), .IS_ROOT(1), .START0(0)) ROOT (
        .clk(clk), .rst(rst), .init_data({RESW{1'b0}}),
        .l_in(is1), .r_in(is2), .s_in(is3),
        .l_start(ist1), .r_start(ist2), .s_start(ist3),
        .state(root_st), .start_out(root_start), .mem_out(result));

    assign root_active = root_start;
endmodule
