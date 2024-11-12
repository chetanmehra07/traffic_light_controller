`timescale 1ns / 1ps

module traffic_final(
    input clk, rst,
    output reg [2:0] l,  // Left output
    output reg [2:0] r,  // Right output
    output reg [2:0] s,  // Straight output
    output reg [2:0] b   // Back output
);
    
    parameter S_left = 0, S_right = 1, S_straight = 2, S_back = 3;
    parameter sec_left = 6, sec_right = 5, sec_straight = 4, sec_back = 6;
    
    reg [2:0] tme;
    reg [2:0] ps;
    reg [26:0] clk_div;  // 27-bit clock divider for 100 MHz to 1 Hz
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_div <= 0;
        end else begin
            clk_div <= clk_div + 1;
        end
    end
    
    wire slow_clk = clk_div[26];  // 1 Hz clock signal
    
    always @(posedge slow_clk or posedge rst) begin
        if (rst) begin
            ps <= S_left;
            tme <= 0;
        end else begin
            case (ps)
                S_left: if (tme < sec_left) begin
                            ps <= S_left;
                            tme <= tme + 1;
                        end else begin 
                            ps <= S_right;
                            tme <= 0;
                        end
                        
                S_right: if (tme < sec_right) begin
                            ps <= S_right;
                            tme <= tme + 1;
                         end else begin 
                            ps <= S_straight;
                            tme <= 0;
                         end
                         
                S_straight: if (tme < sec_straight) begin
                                ps <= S_straight;
                                tme <= tme + 1;
                            end else begin 
                                ps <= S_back;
                                tme <= 0;
                            end
                            
                S_back: if (tme < sec_back) begin
                            ps <= S_back;
                            tme <= tme + 1;
                        end else begin 
                            ps <= S_left;
                            tme <= 0;
                        end
                
                default: ps <= S_left;
            endcase
        end
    end
    
    always @(ps) begin
        case (ps)
            S_left: begin
                l <= 3'b001;
                r <= 3'b010;
                s <= 3'b100;
                b <= 3'b100;
            end
            S_right: begin 
                l <= 3'b100;
                r <= 3'b001;
                s <= 3'b010;
                b <= 3'b100;
            end
            S_straight: begin
                l <= 3'b100;
                r <= 3'b100;
                s <= 3'b001;
                b <= 3'b010;
            end
            S_back: begin
                l <= 3'b010;
                r <= 3'b100;
                s <= 3'b100;
                b <= 3'b001;
            end
            default: begin
                l <= 3'b000;
                r <= 3'b000;
                s <= 3'b000;
                b <= 3'b000;
            end
        endcase
    end

endmodule
