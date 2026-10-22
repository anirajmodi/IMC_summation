module node #(
    parameter MEMW    = 5,
    parameter IS_ROOT = 0,
    parameter START0  = 0
)(
    input  wire            clk,
    input  wire            rst,
    input  wire [MEMW-1:0] init_data,

    input  wire            l_in,
    input  wire            r_in,
    input  wire            s_in,
    input  wire            l_start,
    input  wire            r_start,
    input  wire            s_start,

    output wire            state,
    output wire            start_out,
    output wire [MEMW-1:0] mem_out
);

    reg [MEMW-1:0] mem;
    reg            start;
    reg            st, c1, c2;

    assign state     = st;
    assign start_out = start;
    assign mem_out   = mem;

    wire s = IS_ROOT ? s_in : mem[0];

    wire xrs = l_in ^ r_in ^ s;
    wire maj = (l_in & r_in) | (r_in & s) | (l_in & s);
    wire orv =  l_in | r_in | s;

    wire ns  = xrs ^ c1;
    wire nc1 = maj ^ (c1 & xrs) ^ c2;
    wire nc2 = (l_in & r_in & s & c1) | (c2 & maj) | (c1 & c2 & orv);

    wire nstart = start | l_start | r_start | s_start;

    always @(posedge clk) begin
        if (rst) begin
            mem   <= init_data;
            start <= START0[0];
            st    <= 1'b0;
            c1    <= 1'b0;
            c2    <= 1'b0;
        end else begin
            start <= nstart;
            if (start) begin
                st <= ns;
                c1 <= nc1;
                c2 <= nc2;
                if (IS_ROOT)
                    mem <= {ns, mem[MEMW-1:1]};
                else
                    mem <= {1'b0, mem[MEMW-1:1]};
            end else begin
                st <= 1'b0;
                c1 <= 1'b0;
                c2 <= 1'b0;
            end
        end
    end

endmodule
