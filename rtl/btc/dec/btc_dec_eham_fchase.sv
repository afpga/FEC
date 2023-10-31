/*



  parameter int pLLR_W  = 5 ;
  parameter int pEXTR_W = 5 ;



  logic                   btc_dec_eham_fchase__iclk              ;
  logic                   btc_dec_eham_fchase__ireset            ;
  logic                   btc_dec_eham_fchase__iclkena           ;
  //
  btc_code_mode_t         btc_dec_eham_fchase__imode             ;
  //
  logic                   btc_dec_eham_fchase__ival              ;
  strb_t                  btc_dec_eham_fchase__istrb             ;
  logic                   btc_dec_eham_fchase__iLapri_ptr        ;
  bit_idx_t               btc_dec_eham_fchase__iLpp_idx      [4] ;
  extr_t                  btc_dec_eham_fchase__iLpp_value    [4] ;
  state_t                 btc_dec_eham_fchase__isyndrome         ;
  logic                   btc_dec_eham_fchase__ieven             ;
  logic                   btc_dec_eham_fchase__ierr_idx          ;
  logic                   btc_dec_eham_fchase__idecfail          ;
  //
  extr_t                  btc_dec_eham_fchase__iLapri            ;
  logic                   btc_dec_eham_fchase__oLapri_rptr       ;
  bit_idx_t               btc_dec_eham_fchase__oLapri_raddr      ;
  //
  logic                   btc_dec_eham_fchase__odone             ;
  strb_t                  btc_dec_eham_fchase__ostrb             ;
  metric_t                btc_dec_eham_fchase__omin0             ;
  metric_t                btc_dec_eham_fchase__omin1             ;
  logic           [4 : 0] btc_dec_eham_fchase__oerr_bit_mask     ;
  bit_idx_t               btc_dec_eham_fchase__oerr_bit_idx  [5] ;
  //
  logic                   btc_dec_eham_fchase__odecfail          ;



  btc_dec_eham_fchase
  #(
    .pLLR_W  ( pLLR_W  ) ,
    .pEXTR_W ( pEXTR_W )
  )
  btc_dec_eham_fchase
  (
    .iclk          ( btc_dec_eham_fchase__iclk          ) ,
    .ireset        ( btc_dec_eham_fchase__ireset        ) ,
    .iclkena       ( btc_dec_eham_fchase__iclkena       ) ,
    //
    .imode         ( btc_dec_eham_fchase__imode         ) ,
    //
    .ival          ( btc_dec_eham_fchase__ival          ) ,
    .istrb         ( btc_dec_eham_fchase__istrb         ) ,
    .iLapri_ptr    ( btc_dec_eham_fchase__iLapri_ptr    ) ,
    .iLpp_idx      ( btc_dec_eham_fchase__iLpp_idx      ) ,
    .iLpp_value    ( btc_dec_eham_fchase__iLpp_value    ) ,
    .isyndrome     ( btc_dec_eham_fchase__isyndrome     ) ,
    .ieven         ( btc_dec_eham_fchase__ieven         ) ,
    .ierr_idx      ( btc_dec_eham_fchase__ierr_idx      ) ,
    .idecfail      ( btc_dec_eham_fchase__idecfail      ) ,
    //
    .iLapri        ( btc_dec_eham_fchase__iLapri        ) ,
    .oLapri_rptr   ( btc_dec_eham_fchase__oLapri_rptr   ) ,
    .oLapri_raddr  ( btc_dec_eham_fchase__oLapri_raddr  ) ,
    //
    .odone         ( btc_dec_eham_fchase__odone         ) ,
    .ostrb         ( btc_dec_eham_fchase__ostrb         ) ,
    .omin0         ( btc_dec_eham_fchase__omin0         ) ,
    .omin1         ( btc_dec_eham_fchase__omin1         ) ,
    .oerr_bit_mask ( btc_dec_eham_fchase__oerr_bit_mask ) ,
    .oerr_bit_idx  ( btc_dec_eham_fchase__oerr_bit_idx  ) ,
    //
    .odecfail      ( btc_dec_eham_fchase__odecfail      )
  );


  assign btc_dec_eham_fchase__iclk       = '0 ;
  assign btc_dec_eham_fchase__ireset     = '0 ;
  assign btc_dec_eham_fchase__iclkena    = '0 ;
  assign btc_dec_eham_fchase__imode      = '0 ;
  assign btc_dec_eham_fchase__ival       = '0 ;
  assign btc_dec_eham_fchase__istrb      = '0 ;
  assign btc_dec_eham_fchase__iLapri_ptr = '0 ;
  assign btc_dec_eham_fchase__iLpp_idx   = '0 ;
  assign btc_dec_eham_fchase__iLpp_value = '0 ;
  assign btc_dec_eham_fchase__isyndrome  = '0 ;
  assign btc_dec_eham_fchase__ieven      = '0 ;
  assign btc_dec_eham_fchase__ierr_idx   = '0 ;
  assign btc_dec_eham_fchase__idecfail   = '0 ;
  assign btc_dec_eham_fchase__iLapri     = '0 ;



*/

//
// Project       : wimax BTC
// Author        : Shekhalev Denis (des00)
// Workfile      : btc_dec_eham_fchase.sv
// Description   : extended hamming code fast chase algorithm unit
//                 use 8 candidates for code size 8 and 16 for others
//

module btc_dec_eham_fchase
(
  iclk          ,
  ireset        ,
  iclkena       ,
  //
  imode         ,
  //
  ival          ,
  istrb         ,
  iLapri_ptr    ,
  iLpp_idx      ,
  iLpp_value    ,
  isyndrome     ,
  ieven         ,
  ierr_idx      ,
  idecfail      ,
  //
  iLapri        ,
  oLapri_read   ,
  oLapri_rptr   ,
  oLapri_raddr  ,
  //
  odone         ,
  ostrb         ,
  omin0         ,
  omin1         ,
  oerr_bit_mask ,
  oerr_bit_idx  ,
  //
  odecfail
);

  `include "../btc_parameters.svh"
  `include "btc_dec_types.svh"

  //------------------------------------------------------------------------------------------------------
  //
  //------------------------------------------------------------------------------------------------------

  input  logic                   iclk              ;
  input  logic                   ireset            ;
  input  logic                   iclkena           ;
  //
  input  btc_code_mode_t         imode             ;
  //
  input  logic                   ival              ;
  input  strb_t                  istrb             ;
  input  logic                   iLapri_ptr        ;
  input  bit_idx_t               iLpp_idx      [4] ;
  input  extr_t                  iLpp_value    [4] ;
  input  state_t                 isyndrome         ;
  input  logic                   ieven             ;
  input  bit_idx_t               ierr_idx          ;
  input  logic                   idecfail          ;
  //
  input  extr_t                  iLapri            ;
  output logic                   oLapri_read       ;
  output logic                   oLapri_rptr       ;
  output bit_idx_t               oLapri_raddr      ;
  //
  output logic                   odone             ;
  output strb_t                  ostrb             ;
  output metric_t                omin0             ;
  output metric_t                omin1             ;
  output logic           [4 : 0] oerr_bit_mask     ;
  output bit_idx_t               oerr_bit_idx  [5] ;
  //
  output logic                   odecfail          ;

  //------------------------------------------------------------------------------------------------------
  //
  //------------------------------------------------------------------------------------------------------

  localparam int cCNT_MAX = 16;

  localparam int cCNT_W   = $clog2(cCNT_MAX);

  // only [0:14] needed
  localparam int cEHAM_NEXT_ERAS_POS_IDX  [16] = '{0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,   0};
  localparam bit cEHAM_NEXT_ERAS_POS_PLUS [16] = '{1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0,   0};

  //------------------------------------------------------------------------------------------------------
  //
  //------------------------------------------------------------------------------------------------------

  enum bit {
    cRESET_STATE,
    cDO_STATE
  } state;

  struct packed {
    logic                zero;
    logic                done;
    logic [cCNT_W-1 : 0] value;
  } cnt;

  strb_t        strb      ;

  logic         Lapri_ptr ;

  bit_idx_t     Lpp_idx      [4] ;
  extr_t        Lpp_value    [4] ;
  state_t       syndrome         ;
  logic         even             ;
  bit_idx_t     err_idx          ;
  logic         decfail          ;

  logic         decfail2out;

  metric_t      wacc;

  logic         code_weigth_val;
  logic         code_weigth_sop;
  metric_t      code_weigth;
  logic [3 : 0] code_weigth_eras_idx;
  bit_idx_t     code_weigth_err_idx;
  logic         code_weigth_err_mask;

  logic         chase_val;
  strb_t        chase_strb;

  bit_idx_t     chase_Lpp_idx      [4] ;
  logic         chase_decfail;

  metric_t      min0;
  logic [3 : 0] min0_eras_idx;
  bit_idx_t     min0_err_idx;
  logic         min0_err_mask;

  metric_t      min1;

  logic         sort_val;
  strb_t        sort_strb;

  //------------------------------------------------------------------------------------------------------
  // FSM
  //------------------------------------------------------------------------------------------------------

  always_ff @(posedge iclk or posedge ireset) begin
    if (ireset) begin
      state <= cRESET_STATE;
    end
    else if (iclkena) begin
      case (state)
        cRESET_STATE  : state <= ival               ? cDO_STATE     : cRESET_STATE;
        cDO_STATE     : state <= (cnt.done & !ival) ? cRESET_STATE  : cDO_STATE;
      endcase
    end
  end

  //------------------------------------------------------------------------------------------------------
  //
  //------------------------------------------------------------------------------------------------------
  // synthesis translate_off
  always_ff @(posedge iclk) begin
    if (ival) begin
      if (state == cDO_STATE & !cnt.done) begin
        $error("%m FSM handshake error");
        $stop;
      end
    end
  end
  // synthesis translate_on

  //------------------------------------------------------------------------------------------------------
  // FSM counters
  //------------------------------------------------------------------------------------------------------

  wire [cCNT_W-1 : 0] cnt_max_m2 = (imode.size == cBSIZE_8) ? (8-2) : (16-2);

  always_ff @(posedge iclk) begin
    if (iclkena) begin
      case (state)
        cRESET_STATE : begin
          cnt       <= '0;
          cnt.zero  <= 1'b1;
          //
          strb      <= istrb;
          //
          Lapri_ptr <= iLapri_ptr;
        end
        //
        cDO_STATE : begin
          if (ival) begin
            cnt       <= '0;
            cnt.zero  <= 1'b1;
            //
            strb      <= istrb;
            //
            Lapri_ptr <= iLapri_ptr;
          end
          else begin
            cnt.value <=  cnt.done ? '0 : (cnt.value + 1'b1);
            cnt.done  <= (cnt.value == cnt_max_m2);
            cnt.zero  <=  cnt.done;
          end
        end
      endcase
    end
  end

  assign oLapri_read  = (state == cDO_STATE);
  assign oLapri_rptr  = Lapri_ptr;

  //------------------------------------------------------------------------------------------------------
  // fast chase
  //------------------------------------------------------------------------------------------------------

  logic     no_error;
  logic     error_not_in_lpp_list;

  state_t   tsyndrome ;
  logic     teven     ;
  bit_idx_t terr_idx  ;
  logic     tdecfail  ;
  metric_t  twacc;

  //
  // fast chase logic
  always_comb begin
    bit_idx_t next_eras_pos;
    // condition decoding
    no_error               = (syndrome == 0) & (even == 0);
    //
    error_not_in_lpp_list  = (err_idx != Lpp_idx[0]);
    error_not_in_lpp_list &= (err_idx != Lpp_idx[1]);
    error_not_in_lpp_list &= (err_idx != Lpp_idx[2]);
    if (imode.size != cBSIZE_8) begin
      error_not_in_lpp_list &= (err_idx != Lpp_idx[3]);
    end
    // fast chase step
    teven         = !even;
    next_eras_pos = Lpp_idx[cEHAM_NEXT_ERAS_POS_IDX[cnt.value]];
    //
    tsyndrome     = syndrome;
    terr_idx      = '0;
    case (imode.size)
      cBSIZE_8  : begin
        if (next_eras_pos != 7) begin
          tsyndrome ^= cH_7_TAB [next_eras_pos[2 : 0]];
        end
        terr_idx = cH_7_ERR_IDX_TAB [tsyndrome[2 : 0]];
      end
      //
      cBSIZE_16 : begin
        if (next_eras_pos != 15) begin
          tsyndrome ^= cH_15_TAB [next_eras_pos[3 : 0]];
        end
        terr_idx = cH_15_ERR_IDX_TAB[tsyndrome[3 : 0]];
      end
      //
      cBSIZE_32 : begin
        if (next_eras_pos != 31) begin
          tsyndrome ^= cH_31_TAB [next_eras_pos[4 : 0]];
        end
        terr_idx = cH_31_ERR_IDX_TAB[tsyndrome[4 : 0]];
      end
      //
      cBSIZE_64 : begin
        if (next_eras_pos != 63) begin
          tsyndrome ^= cH_63_TAB [next_eras_pos[5 : 0]];
        end
        terr_idx = cH_63_ERR_IDX_TAB[tsyndrome[5 : 0]];
      end
    endcase
    //
    tdecfail = (tsyndrome != 0) & (teven == 0);
    //
    twacc    = cEHAM_NEXT_ERAS_POS_PLUS[cnt.value] ? (wacc + Lpp_value[cEHAM_NEXT_ERAS_POS_IDX[cnt.value]]) :
                                                     (wacc - Lpp_value[cEHAM_NEXT_ERAS_POS_IDX[cnt.value]]);
  end

  assign oLapri_raddr = err_idx;

  //
  // fast chase registers

  always_ff @(posedge iclk or posedge ireset) begin
    if (ireset) begin
      chase_val <= 1'b0;
    end
    else if (iclkena) begin
      chase_val <= (state == cDO_STATE) & cnt.done;
    end
  end

  always_ff @(posedge iclk) begin
    if (iclkena) begin
      code_weigth_val <= 1'b0;
      code_weigth_sop <= 1'b0;
      //
      case (state)
        cRESET_STATE : begin
          if (ival) begin // init chase
            // hold chase context
            Lpp_idx     <= iLpp_idx;
            Lpp_value   <= iLpp_value;
            // init chase
            syndrome    <= isyndrome;
            even        <= ieven;
            err_idx     <= ierr_idx;
            decfail     <= idecfail;
            wacc        <= '0;
            // latch initial for fast decision
            decfail2out <= idecfail;
          end
        end
        //
        cDO_STATE : begin
          code_weigth_sop <= cnt.zero;
          //
          if (ival) begin // init fast chase
            // hold chase context
            Lpp_idx     <= iLpp_idx;
            Lpp_value   <= iLpp_value;
            // init chase
            syndrome    <= isyndrome;
            even        <= ieven;
            err_idx     <= ierr_idx;
            decfail     <= idecfail;
            wacc        <= '0;
            // latch initial for fast decision
            decfail2out <= idecfail;
          end
          else begin // fast chase
            // chase step
            syndrome  <= tsyndrome;
            even      <= teven;
            err_idx   <= terr_idx;
            decfail   <= tdecfail;
            wacc      <= twacc;
          end
          //
          // chase decode
          if (!decfail) begin
            if (no_error) begin
              code_weigth_val       <= 1'b1;
              code_weigth           <= wacc;
              code_weigth_eras_idx  <= cnt.value;
              code_weigth_err_idx   <= '0;
              code_weigth_err_mask  <= 1'b0; // no error
            end
            else if (error_not_in_lpp_list) begin
              code_weigth_val       <= 1'b1;
//            code_weigth           <= wacc + ((iLapri >= 0) ? iLapri : -iLapri);
              code_weigth           <= wacc + $signed({1'b0, iLapri[$high(iLapri)-1 : 0]}); // Lapri in {sign, abs} format (!!!)
              code_weigth_eras_idx  <= cnt.value;
              code_weigth_err_idx   <= err_idx;
              code_weigth_err_mask  <= 1'b1; // is error at err idx
            end
          end
          //
          // hold chase context
          if (cnt.done) begin
            chase_strb    <= strb;
            chase_Lpp_idx <= Lpp_idx;
            chase_decfail <= decfail2out;
          end
        end
      endcase
    end
  end

  //------------------------------------------------------------------------------------------------------
  // metric sorting to search maximim probably codeword
  //------------------------------------------------------------------------------------------------------

  always_ff @(posedge iclk or posedge ireset) begin
    if (ireset) begin
      sort_val <= 1'b0;
    end
    else if (iclkena) begin
      sort_val <= chase_val;
    end
  end

  always_ff @(posedge iclk) begin
    if (iclkena) begin
      if (code_weigth_sop) begin
        if (code_weigth_val) begin
          min0          <= code_weigth;
          min0_eras_idx <= code_weigth_eras_idx;
          min0_err_idx  <= code_weigth_err_idx;
          min0_err_mask <= code_weigth_err_mask;
        end
        else begin
          // set maximim
          min0              <= '1;
          min0[$high(min0)] <= 1'b0;
        end
        // set maximim
        min1              <= '1;
        min1[$high(min1)] <= 1'b0;
      end
      else if (code_weigth_val) begin
        if (code_weigth < min0) begin
          min0          <= code_weigth;
          min0_eras_idx <= code_weigth_eras_idx;
          min0_err_idx  <= code_weigth_err_idx;
          min0_err_mask <= code_weigth_err_mask;
          //
          min1          <= min0;
        end
        else if (code_weigth < min1) begin
          min1          <= code_weigth;
        end
      end // code_weigth_val
    end // iclkena
  end // iclk

  //------------------------------------------------------------------------------------------------------
  // decoding results
  //------------------------------------------------------------------------------------------------------

  always_ff @(posedge iclk or posedge ireset) begin
    if (ireset) begin
      odone <= 1'b0;
    end
    else if (iclkena) begin
      odone <= sort_val;
    end
  end

  // bit idx hold at least 7 ticks and latched inside hamm_decision unit
  always_comb begin
    oerr_bit_idx [0 : 3]  = chase_Lpp_idx;
    odecfail              = chase_decfail;
  end

  always_ff @(posedge iclk) begin
    if (iclkena) begin
      ostrb <= chase_strb;
      if (sort_val) begin
        omin0 <= min0;
        omin1 <= min1;
        // bin2gray idx
        oerr_bit_mask[3 : 0] <= (min0_eras_idx >> 1) ^ min0_eras_idx;
//      oerr_bit_idx [0 : 3] <= chase_Lpp_idx;
        //
        oerr_bit_mask[4]     <= min0_err_mask;
        oerr_bit_idx [4]     <= min0_err_idx;
      end
    end
  end

endmodule
