*&---------------------------------------------------------------------*
*&  Include           Z_MESSAGES_CLASSES
*&---------------------------------------------------------------------*


CLASS lcl_messages_internal IMPLEMENTATION.

  METHOD lif_messages_internal~set_current_context.
    set_current_context( is_current_context ).
  ENDMETHOD.
  METHOD lif_messages_internal~set_current_params.
    set_current_params( is_current_params ).
  ENDMETHOD.
  METHOD lif_messages_internal~get_current_params.
    rs_current_params = get_current_params( ).
  ENDMETHOD.
  METHOD lif_messages_internal~get_current_context.
    rs_current_context = get_current_context( ).
  ENDMETHOD.
  METHOD lif_messages_internal~set_current_level.
    set_current_level( iv_current_level ).
  ENDMETHOD.                    "lif_messages_internal~set_current_level
  METHOD lif_messages_internal~set_current_probclass.
    set_current_probclass( iv_current_probclass ).
  ENDMETHOD.                    "lif_messages_internal~set_current_probclass
  METHOD lif_messages_internal~get_current_level.
    rv_current_level = get_current_level( ).
  ENDMETHOD.                    "lif_messages_internal~get_current_level
  METHOD lif_messages_internal~get_current_probclass.
    rv_current_probclass = get_current_probclass( ).
  ENDMETHOD.                    "lif_messages_internal~get_current_probclass

  METHOD lif_messages_internal~copy.
    copy( ii_messages = ii_messages ).
  ENDMETHOD.                    "lif_messages_internal~copy

  METHOD copy.
    DATA lo_messages TYPE REF TO lcl_messages_internal.
    lo_messages ?= ii_messages.
    mt_messages = lo_messages->mt_messages.
    mv_messages_count = lo_messages->mv_messages_count.
    mv_default_msg_type = lo_messages->mv_default_msg_type.
    mv_current_level    =  lo_messages->mv_current_level.
    mv_current_probclass = lo_messages->mv_current_probclass.
    mv_severity = lo_messages->mv_severity.
  ENDMETHOD.                    "copy
  METHOD lif_messages_internal~add_n_raise.
    add( EXPORTING messages = messages
                   iv_msgty = iv_msgty ).
  ENDMETHOD.                    "lif_messages_internal~add_n_raise

  METHOD lif_messages_internal~add.
    TRY.
        add( EXPORTING messages = messages
                       iv_msgty = iv_msgty ).
      CATCH lcx_e_or_a_type_occurs.    "
    ENDTRY.
  ENDMETHOD.                    "lif_messages_internal~add
  METHOD lif_messages_internal~get.
    TRY.
        get( IMPORTING messages = messages ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
  ENDMETHOD.                    "lif_messages_internal~get
  METHOD add.

    DATA lt_internal TYPE ty_t_internal_message.

    mapping_to_internal(
      EXPORTING
        messages = messages
        iv_msgty = iv_msgty
      IMPORTING
        et_internal = lt_internal ).

    append_t( it_messages =  lt_internal ).
*      CATCH lcx_e_or_a_type_occurs.    "

  ENDMETHOD.                    "add

  METHOD mapping_internal_to_bapiret2.

    es_external-type        = is_internal-type.
    es_external-id          = is_internal-id.
    es_external-number      = is_internal-number.
    es_external-message_v1  = is_internal-message_v1.
    es_external-message_v2  = is_internal-message_v2.
    es_external-message_v3  = is_internal-message_v3.
    es_external-message_v4  = is_internal-message_v4.
    IF NOT is_internal-message IS INITIAL.
      es_external-message = is_internal-message.
    ELSEIF NOT es_external-type IS INITIAL.
      MESSAGE ID es_external-id
      TYPE es_external-type
      NUMBER es_external-number
      WITH es_external-message_v1
           es_external-message_v2
           es_external-message_v3
           es_external-message_v4
           INTO es_external-message.
    ENDIF.

  ENDMETHOD.                    "mapping_internal_to_bapiret2
  METHOD lif_messages_internal~to_string.
    rv_messages = to_string( ).
  ENDMETHOD.

  METHOD to_string.
    DATA ls_message TYPE ty_internal_message.
    LOOP AT mt_messages INTO ls_message.
      rv_messages = rv_messages  &&
      ls_message-message     && ';' &&
      ls_message-type        && ';' &&
      ls_message-id          && ';' &&
      ls_message-number      && ';' &&
      ls_message-log_no      && ';' &&
      ls_message-log_msg_no  && ';' &&
      ls_message-message_v1  && ';' &&
      ls_message-message_v2  && ';' &&
      ls_message-message_v3  && ';' &&
      ls_message-message_v4.

    ENDLOOP.
  ENDMETHOD.

  METHOD get.

    mapping_to_external(
      IMPORTING
        messages = messages ).

  ENDMETHOD.                    "get
  METHOD mapping_to_internal.
    " to redefine.
    RAISE EXCEPTION TYPE cx_sy_move_cast_error.
  ENDMETHOD.                    "mapping_to_internal
  METHOD mapping_to_external.
    " to redefine.
    RAISE EXCEPTION TYPE cx_sy_move_cast_error.
  ENDMETHOD.                    "mapping_to_external

  METHOD set_current_level.
    mv_current_level = iv_current_level.
  ENDMETHOD.                    "set_current_level
  METHOD set_current_context.
    ms_current_context = is_current_context.
  ENDMETHOD.
  METHOD set_current_params.
    ms_current_params = is_current_params.
  ENDMETHOD.

  METHOD set_current_probclass.
    mv_current_probclass = iv_current_probclass.
  ENDMETHOD.                    "set_current_probclass

  METHOD get_current_level.
    rv_current_level = mv_current_level.
  ENDMETHOD.                    "get_current_level
  METHOD get_current_params.
    rs_current_params = ms_current_params.
  ENDMETHOD.
  METHOD get_current_context.
    rs_current_context = ms_current_context.
  ENDMETHOD.
  METHOD set_default_msg_type.
    mv_default_msg_type = iv_default_msg_type.
  ENDMETHOD.                    "set_default_msg_type
  METHOD lif_messages_internal~get_severity.
    rv_severity = get_severity( ).
  ENDMETHOD.                    "lif_messages_internal~get_severity
  METHOD lif_messages_internal~get_integer_severity.
    rv_severity = get_integer_severity( ).
  ENDMETHOD.
  METHOD get_default_msg_type.
    rv_default_msg_type = mv_default_msg_type.
  ENDMETHOD.                    "get_default_msg_type
  METHOD lif_messages_internal~set_default_msg_type.
    mv_default_msg_type = iv_default_msg_type.
  ENDMETHOD.                    "lif_messages_internal~set_default_msg_type
  METHOD lif_messages_internal~get_default_msg_type.
    rv_default_msg_type = mv_default_msg_type.
  ENDMETHOD.                    "lif_messages_internal~get_default_msg_type
  METHOD lif_messages_internal~get_messages_count.
    rv_count = get_messages_count( ).
  ENDMETHOD.                    "lif_messages_internal~get_messages_count

  METHOD get_current_probclass.
    rv_current_probclass = mv_current_probclass.
  ENDMETHOD.                    "get_current_probclass

  METHOD get_mt_messages.
    et_messages = mt_messages.
  ENDMETHOD.                    "get_mt_messages
  METHOD get_messages_count.
    rv_count = mv_messages_count.
  ENDMETHOD.                    "get_messages_count

  METHOD add_string_to_internal.

    DATA: lv_string_length TYPE i,
          lv_offset        TYPE i,
          lv_length        TYPE i,
          ls_message       TYPE ty_internal_message.

    IF string IS INITIAL.
      RETURN.
    ENDIF.
    lv_string_length = strlen( string ).
    ls_message = is_message.

    DO.
      lv_length = nmin( val1 = 220 val2 = lv_string_length ).
      ls_message-message = string+lv_offset(lv_length).
      APPEND ls_message TO et_messages.
      lv_offset = lv_length.
      lv_string_length = lv_string_length - lv_length.
      IF lv_string_length = 0.
        EXIT.
      ENDIF.
    ENDDO.

  ENDMETHOD.                    "add_string_to_internal
  METHOD append_to_internal.
*
*    DATA: lr_typedescr  TYPE REF TO cl_abap_typedescr,
*          lr_tabdescr   TYPE REF TO cl_abap_tabledescr,
*          lr_strucdescr TYPE REF TO cl_abap_structdescr,
*          lv_type_name  TYPE string.
*
*    FIELD-SYMBOLS :
*      <fs_internal>   TYPE ty_internal_message,
*      <fs_internal_t> TYPE ty_t_internal_message.
*
*    CHECK NOT internal IS INITIAL.
*
**    TRY.
*    lr_typedescr ?= cl_abap_typedescr=>describe_by_data_ref( internal ).
*    CASE lr_typedescr->type_kind.
*
*      WHEN cl_abap_typedescr=>typekind_table.
*        lr_tabdescr ?= lr_typedescr.
**            TRY.
**                lr_strucdescr ?= lr_tabdescr->get_table_line_type( ).
**                lv_type_name = lr_strucdescr->get_relative_name( ).
**                IF NOT lv_type_name = 'BAPIRET2'.
***                RAISE EXCEPTION TYPE lcx_error_occurs.
**                  RAISE EXCEPTION TYPE cx_sy_move_cast_error.
**                ENDIF.
*        ASSIGN internal->* TO <fs_internal_t>.
*        IF NOT <fs_internal_t> IS ASSIGNED.
**                RAISE EXCEPTION TYPE lcx_error_occurs.
*          RAISE EXCEPTION TYPE cx_sy_move_cast_error.
*        ENDIF.
*        append_t( it_messages = <fs_internal_t> ).
**                  CATCH lcx_e_or_a_type_occurs.    "
**              CATCH cx_sy_move_cast_error.
**            ENDTRY.
*      WHEN cl_abap_typedescr=>typekind_struct1.
**            lr_strucdescr ?= lr_typedescr.
**            lv_type_name = lr_strucdescr->get_relative_name( ).
**            IF NOT lv_type_name = 'BAPIRET2'.
***            RAISE EXCEPTION TYPE lcx_error_occurs.
**              RAISE EXCEPTION TYPE cx_sy_move_cast_error.
**            ENDIF.
*        ASSIGN internal->* TO <fs_internal>.
*        IF NOT <fs_internal> IS ASSIGNED.
**            RAISE EXCEPTION TYPE lcx_error_occurs.
*          RAISE EXCEPTION TYPE cx_sy_move_cast_error.
*        ENDIF.
*        append( is_message = <fs_internal> ).
**                  CATCH lcx_e_or_a_type_occurs.    "
*    ENDCASE.
**    ENDTRY.


  ENDMETHOD.                    "append_to_internal
  METHOD constructor.
    reset_default_values( ).
  ENDMETHOD.                    "constructor
  METHOD get_severity.
    rv_severity = mv_severity.
  ENDMETHOD.                    "get_severity
  METHOD get_integer_severity.
    rv_severity = 0.
    CASE mv_severity.
      WHEN 'S'.
        rv_severity = 1.
      WHEN 'I'.
        rv_severity = 2.
      WHEN 'W'.
        rv_severity = 3.
      WHEN 'E'.
        rv_severity = 4.
      WHEN 'A'.
        rv_severity = 5.
    ENDCASE.
  ENDMETHOD.
  METHOD adjust_severity.
    CASE mv_severity.
      WHEN 'A'.
        RETURN.
      WHEN 'E'.
        IF iv_severity <> 'A'.
          RETURN.
        ENDIF.
      WHEN 'W'.
        IF  iv_severity <> 'A'
        AND iv_severity <> 'E'.
          RETURN.
        ENDIF.
    ENDCASE.

    mv_severity = iv_severity.
  ENDMETHOD.                    "adjust_severity
  METHOD reset_default_values.
    mv_current_level     = '1'.
    mv_current_probclass = ''.
    mv_default_msg_type  = 'E' .
  ENDMETHOD.                    "reset_default_value
  METHOD lif_messages_internal~clear.
    clear( ).
  ENDMETHOD.                    "lif_messages_internal~clear
  METHOD clear.
    CLEAR: mt_messages,
    mv_severity,
    mv_messages_count.
    reset_default_values( ).
  ENDMETHOD.                    "clear
  METHOD append.

    DATA ls_message TYPE ty_internal_message.

    CHECK NOT is_message IS INITIAL.

    MOVE-CORRESPONDING is_message TO ls_message.
    ls_message-index = mv_messages_count.
    IF ls_message-level IS INITIAL.
      ls_message-level = mv_current_level.
    ENDIF.
    IF ls_message-probclass IS INITIAL.
      ls_message-probclass = mv_current_probclass.
    ENDIF.
    IF ls_message-type IS INITIAL.
      ls_message-type = mv_default_msg_type.
    ENDIF.
    IF ls_message-context IS INITIAL.
      ls_message-context = ms_current_context.
    ENDIF.
    IF ls_message-params IS INITIAL.
      ls_message-params = ms_current_params.
    ENDIF.
    IF ls_message-message IS INITIAL.
      MESSAGE ID ls_message-id TYPE ls_message-type NUMBER ls_message-number INTO ls_message-message.
    ENDIF.

    APPEND ls_message TO mt_messages.
    mv_messages_count = mv_messages_count + 1.

    adjust_severity( is_message-type ).

    IF is_message-type = 'A'
    OR is_message-type = 'E'.
      RAISE EXCEPTION TYPE lcx_e_or_a_type_occurs.
    ENDIF.

  ENDMETHOD.                    "append
  METHOD append_t.

    DATA: lv_raise_exception TYPE boolean,
          ls_message         TYPE ty_internal_message.

    LOOP AT it_messages INTO ls_message.
      TRY .
          append( ls_message ).
        CATCH lcx_e_or_a_type_occurs.    "
          lv_raise_exception = abap_true.
      ENDTRY.
    ENDLOOP.

    IF lv_raise_exception = abap_true.
      RAISE EXCEPTION TYPE lcx_e_or_a_type_occurs.
    ENDIF.

  ENDMETHOD.                    "append_t

ENDCLASS.                    "lcl_messages_internal IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_system IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_system IMPLEMENTATION.

  METHOD mapping_to_internal.

    DATA: ls_internal TYPE ty_internal_message.

    IF sy-msgid IS INITIAL
    OR sy-msgty IS INITIAL
    OR sy-msgno IS INITIAL.
      RETURN.
    ENDIF.

    ls_internal-id          = sy-msgid.
    ls_internal-type        = sy-msgty.
    ls_internal-number      = sy-msgno.
    ls_internal-message_v1  = sy-msgv1.
    ls_internal-message_v2  = sy-msgv2.
    ls_internal-message_v3  = sy-msgv3.
    ls_internal-message_v4  = sy-msgv4.
    APPEND ls_internal TO et_internal.


  ENDMETHOD.                    "mapping_to_internal

ENDCLASS.                    "lcl_messages_system IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS lcl_messages_if_message IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_if_message IMPLEMENTATION.
  METHOD mapping_to_internal.

    DATA :
      li_message TYPE REF TO if_message,
      lv_message TYPE string,
      ls_message TYPE ty_internal_message.

    li_message = messages.

    IF iv_msgty IS INITIAL.
      ls_message-type    = get_default_msg_type( ).
    ELSE.
      ls_message-type    = iv_msgty.
    ENDIF.
    lv_message = li_message->get_text( ).

    add_string_to_internal(
      EXPORTING
        string      = lv_message
        is_message  = ls_message
      IMPORTING
        et_messages = et_internal ).


  ENDMETHOD.                    "mapping_to_internal
ENDCLASS.                    "lcl_messages_if_message IMPLEMENTATION

CLASS lcl_messages_bapiret1 IMPLEMENTATION.
  METHOD mapping_to_internal.

    DATA: ls_bapiret1 TYPE bapiret1,
          ls_internal TYPE ty_internal_message.

    ls_bapiret1 = messages.
    IF ls_bapiret1 IS INITIAL.
      RETURN.
    ENDIF.
    MOVE-CORRESPONDING ls_bapiret1 TO ls_internal.
    APPEND ls_internal TO et_internal.


  ENDMETHOD.                    "mapping_to_internal
ENDCLASS.

CLASS lcl_messages_bapiret1_t IMPLEMENTATION.
  METHOD mapping_to_internal.

    DATA: ls_bapiret1 TYPE bapiret1,
          lt_bapiret1 TYPE STANDARD TABLE OF bapiret1 WITH DEFAULT KEY,
          ls_internal TYPE ty_internal_message.

    lt_bapiret1 = messages.
    LOOP AT lt_bapiret1 INTO ls_bapiret1.
      MOVE-CORRESPONDING ls_bapiret1 TO ls_internal.
      APPEND ls_internal TO et_internal.
      CLEAR: ls_bapiret1, ls_internal.
    ENDLOOP.


  ENDMETHOD.                    "mapping_to_internal
ENDCLASS.
*----------------------------------------------------------------------*
*       CLASS lcl_messages_balloghndl IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_balloghndl IMPLEMENTATION.

  METHOD mapping_to_internal.

* "if BAL_LOG_READ exists
    FIELD-SYMBOLS: <fs_bal_s_msg> TYPE bal_s_msg.

    DATA: lt_t_msg      TYPE STANDARD TABLE OF bal_s_msg WITH DEFAULT KEY,
          lv_log_handle TYPE balloghndl,
          ls_internal   TYPE ty_internal_message.

    lv_log_handle = messages.

    CALL FUNCTION 'BAL_LOG_READ'
      EXPORTING
        i_log_handle  = lv_log_handle
        et_msg        = lt_t_msg
      EXCEPTIONS
        log_not_found = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.


    LOOP AT lt_t_msg ASSIGNING <fs_bal_s_msg>.
      ls_internal-type        = <fs_bal_s_msg>-msgty.
      ls_internal-id          = <fs_bal_s_msg>-msgid.
      ls_internal-number      = <fs_bal_s_msg>-msgno.
      ls_internal-message_v1  = <fs_bal_s_msg>-msgv1.
      ls_internal-message_v2  = <fs_bal_s_msg>-msgv2.
      ls_internal-message_v3  = <fs_bal_s_msg>-msgv3.
      ls_internal-message_v4  = <fs_bal_s_msg>-msgv4.
      ls_internal-message_v4  = <fs_bal_s_msg>-msgv4.
      ls_internal-level       = <fs_bal_s_msg>-detlevel.
      ls_internal-probclass   = <fs_bal_s_msg>-probclass.
      IF ls_internal-type IS INITIAL.
        ls_internal-type = iv_msgty.
      ENDIF.
      APPEND ls_internal TO et_internal.
      CLEAR ls_internal.
    ENDLOOP.

*    " BAL_LOG_READ doesn't exist, we use BAL_GLB_SEARCH_MSG
*    FIELD-SYMBOLS: <fs_bal_s_msg> TYPE bal_s_msg.
*
*    DATA: lt_t_msg      TYPE STANDARD TABLE OF bal_s_msg WITH DEFAULT KEY,
*          lv_log_handle TYPE balloghndl,
*          ls_internal   TYPE ty_internal_message,
*          lt_log_handle TYPE bal_t_logh,
*          lt_msg_handle TYPE bal_t_msgh,
*          ls_msg_handle TYPE BALMSGHNDL,
*          ls_s_msg      TYPE bal_s_msg.
*
*    lv_log_handle = messages.
*
*    APPEND lv_log_handle TO lt_log_handle.
*
**    " in memory ?
*    CALL FUNCTION 'BAL_GLB_SEARCH_MSG'
*      EXPORTING
*        i_t_log_handle = lt_log_handle
*      IMPORTING
*        e_t_msg_handle = lt_msg_handle
*      EXCEPTIONS
*        msg_not_found  = 1
*        OTHERS         = 2.
*    IF NOT sy-subrc = 0.
*      " in DB ?
*      CALL FUNCTION 'BAL_DB_LOAD'
*        EXPORTING
*          i_t_log_handle     = lt_log_handle
*        IMPORTING
**         E_T_LOG_HANDLE     =
*          e_t_msg_handle     = lt_msg_handle
**         E_T_LOCKED         =
*        EXCEPTIONS
*          no_logs_specified  = 1
*          log_not_found      = 2
*          log_already_loaded = 3
*          OTHERS             = 4.
*      IF sy-subrc <> 0.
*        "nothing found.
*        RETURN.
*      ENDIF.
*    ENDIF.
*
*    LOOP AT lt_msg_handle INTO ls_msg_handle.
*      CALL FUNCTION 'BAL_LOG_MSG_READ'
*        EXPORTING
*          i_s_msg_handle = ls_msg_handle
*        IMPORTING
*          e_s_msg        = ls_s_msg
*        EXCEPTIONS
*          log_not_found  = 1
*          msg_not_found  = 2
*          OTHERS         = 3.
*      IF sy-subrc <> 0.
*        CONTINUE.
*      ENDIF.
*      ls_internal-type        = ls_s_msg-msgty.
*      ls_internal-id          = ls_s_msg-msgid.
*      ls_internal-number      = ls_s_msg-msgno.
*      ls_internal-message_v1  = ls_s_msg-msgv1.
*      ls_internal-message_v2  = ls_s_msg-msgv2.
*      ls_internal-message_v3  = ls_s_msg-msgv3.
*      ls_internal-message_v4  = ls_s_msg-msgv4.
*      ls_internal-message_v4  = ls_s_msg-msgv4.
*      ls_internal-level       = ls_s_msg-detlevel.
*      ls_internal-probclass   = ls_s_msg-probclass.
*      IF ls_internal-type IS INITIAL.
*        ls_internal-type = iv_msgty.
*      ENDIF.
*      APPEND ls_internal TO et_internal.
*      CLEAR ls_internal.
*    ENDLOOP.
  ENDMETHOD.

  METHOD mapping_to_external.

    DATA:
      lt_messages   TYPE ty_t_internal_message,
      ls_message    TYPE ty_internal_message,
      li_log        TYPE REF TO lif_log,
      lv_log_handle TYPE balloghndl,
      ls_ballog     TYPE bal_s_msg.

    get_mt_messages(
      IMPORTING
        et_messages = lt_messages ).

    lv_log_handle = messages.

    LOOP AT lt_messages INTO ls_message.

      IF NOT ls_message-id IS INITIAL.
        ls_ballog-msgty      = ls_message-type.
        ls_ballog-msgid      = ls_message-id.
        ls_ballog-msgno      = ls_message-number.
        ls_ballog-msgv1      = ls_message-message_v1.
        ls_ballog-msgv2      = ls_message-message_v2.
        ls_ballog-msgv3      = ls_message-message_v3.
        ls_ballog-msgv4      = ls_message-message_v4.
        ls_ballog-detlevel   = ls_message-level.
        ls_ballog-probclass  = ls_message-probclass.



        CALL FUNCTION 'BAL_LOG_MSG_ADD'
          EXPORTING
            i_log_handle     = lv_log_handle
            i_s_msg          = ls_ballog
          EXCEPTIONS
            log_not_found    = 1
            msg_inconsistent = 2
            log_is_full      = 3
            OTHERS           = 4.

        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

      ELSE.
        CALL FUNCTION 'BAL_LOG_MSG_ADD_FREE_TEXT'
          EXPORTING
            i_log_handle     = lv_log_handle
            i_msgty          = ls_message-type
            i_text           = ls_message-message
            i_probclass      = ls_message-probclass
          EXCEPTIONS
            log_not_found    = 1
            msg_inconsistent = 2
            log_is_full      = 3
            OTHERS           = 4.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.                    "mapping_to_external

ENDCLASS.                    "lcl_messages_balloghndl IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS lcl_messages_bal_t_msg IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bal_t_msg IMPLEMENTATION.
  METHOD mapping_to_external.

    DATA:
      lt_messages TYPE ty_t_internal_message,
      ls_message  TYPE ty_internal_message,
      lt_bal_msg  TYPE STANDARD TABLE OF bal_s_msg WITH DEFAULT KEY,
      ls_bapiret2 TYPE bal_s_msg.

    get_mt_messages(
      IMPORTING
        et_messages = lt_messages ).

    LOOP AT lt_messages INTO ls_message.

      ls_bapiret2-msgty      = ls_message-type.
      ls_bapiret2-msgid      = ls_message-id.
      ls_bapiret2-msgno      = ls_message-number.
      ls_bapiret2-msgv1      = ls_message-message_v1.
      ls_bapiret2-msgv2      = ls_message-message_v2.
      ls_bapiret2-msgv3      = ls_message-message_v3.
      ls_bapiret2-msgv4      = ls_message-message_v4.
      ls_bapiret2-detlevel   = ls_message-level.
      ls_bapiret2-probclass  = ls_message-probclass.
      APPEND ls_bapiret2 TO lt_bal_msg.


    ENDLOOP.

    messages = lt_bal_msg.

  ENDMETHOD.                    "mapping_to_external

  METHOD mapping_to_internal.

    FIELD-SYMBOLS: <fs_bal_s_msg> TYPE bal_s_msg.

    DATA: lt_t_msg    TYPE STANDARD TABLE OF bal_s_msg WITH DEFAULT KEY,
          ls_internal TYPE ty_internal_message.

    lt_t_msg = messages.

    LOOP AT lt_t_msg ASSIGNING <fs_bal_s_msg>.
      ls_internal-type        = <fs_bal_s_msg>-msgty.
      ls_internal-id          = <fs_bal_s_msg>-msgid.
      ls_internal-number      = <fs_bal_s_msg>-msgno.
      ls_internal-message_v1  = <fs_bal_s_msg>-msgv1.
      ls_internal-message_v2  = <fs_bal_s_msg>-msgv2.
      ls_internal-message_v3  = <fs_bal_s_msg>-msgv3.
      ls_internal-message_v4  = <fs_bal_s_msg>-msgv4.
      IF ls_internal-type IS INITIAL.
        ls_internal-type = iv_msgty.
      ENDIF.
      APPEND ls_internal TO et_internal.
      CLEAR ls_internal.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.                    "lcl_messages_bal_t_msg IMPLEMENTATION


*----------------------------------------------------------------------*
*       CLASS lcl_messages_bal_t_msg IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bal_s_msg IMPLEMENTATION.
  METHOD mapping_to_external.

    DATA:
      lt_messages TYPE ty_t_internal_message,
      ls_message  TYPE ty_internal_message,
      ls_s_msg TYPE bal_s_msg.

    get_mt_messages(
      IMPORTING
        et_messages = lt_messages ).

    READ TABLE lt_messages INTO ls_message INDEX 1.
    IF sy-subrc IS INITIAL.

      ls_s_msg-msgty      = ls_message-type.
      ls_s_msg-msgid      = ls_message-id.
      ls_s_msg-msgno      = ls_message-number.
      ls_s_msg-msgv1      = ls_message-message_v1.
      ls_s_msg-msgv2      = ls_message-message_v2.
      ls_s_msg-msgv3      = ls_message-message_v3.
      ls_s_msg-msgv4      = ls_message-message_v4.
      ls_s_msg-detlevel   = ls_message-level.
      ls_s_msg-probclass  = ls_message-probclass.
    ENDIF.

    messages = ls_s_msg.

  ENDMETHOD.                    "mapping_to_external

  METHOD mapping_to_internal.

    DATA: ls_s_msg    TYPE  bal_s_msg,
          ls_internal TYPE ty_internal_message.

    ls_s_msg = messages.

    ls_internal-type        = ls_s_msg-msgty.
    ls_internal-id          = ls_s_msg-msgid.
    ls_internal-number      = ls_s_msg-msgno.
    ls_internal-message_v1  = ls_s_msg-msgv1.
    ls_internal-message_v2  = ls_s_msg-msgv2.
    ls_internal-message_v3  = ls_s_msg-msgv3.
    ls_internal-message_v4  = ls_s_msg-msgv4.
    IF ls_internal-type IS INITIAL.
      ls_internal-type = iv_msgty.
    ENDIF.
    APPEND ls_internal TO et_internal.
    CLEAR ls_internal.

  ENDMETHOD.

ENDCLASS.



*----------------------------------------------------------------------*
*       CLASS lcl_messages_bapi_order_rtrn_t IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bapi_order_rtrn_t IMPLEMENTATION.

  METHOD mapping_to_internal.

    FIELD-SYMBOLS : <ls_order_return> TYPE bapi_order_return.

    DATA: lt_bapi_order_return TYPE STANDARD TABLE OF bapi_order_return WITH DEFAULT KEY,
          ls_internal          TYPE ty_internal_message.

    lt_bapi_order_return = messages.

    LOOP AT lt_bapi_order_return ASSIGNING <ls_order_return>.
      MOVE-CORRESPONDING <ls_order_return> TO ls_internal.
      IF ls_internal-type IS INITIAL.
        ls_internal-type = iv_msgty.
      ENDIF.
      APPEND ls_internal TO et_internal.
      CLEAR ls_internal.
    ENDLOOP.

  ENDMETHOD.                    "mapping_to_internal

ENDCLASS.                    "lcl_messages_bapi_order_rtrn_t IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_lif_messages IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_lif_messages IMPLEMENTATION.

  METHOD mapping_to_internal.

    FIELD-SYMBOLS : <fs_bapiret2>   TYPE bapiret2.

    DATA: ls_internal TYPE ty_internal_message,
          lt_bapiret2 TYPE bapiret2_t,
          li_messages TYPE REF TO lif_messages.

    li_messages ?= messages.
    li_messages->get( IMPORTING messages = lt_bapiret2 ).
    LOOP AT lt_bapiret2 ASSIGNING <fs_bapiret2>.
      MOVE-CORRESPONDING <fs_bapiret2> TO ls_internal.
      APPEND ls_internal TO et_internal.
      CLEAR ls_internal.
    ENDLOOP.

  ENDMETHOD.                    "mapping_to_internal

ENDCLASS.                    "lcl_messages_lif_messages IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_bdcmsgcoll_t IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bdcmsgcoll_t IMPLEMENTATION.

  METHOD mapping_to_internal.

    FIELD-SYMBOLS : <fs_bapiret2>   TYPE bapiret2.

    DATA: ls_internal   TYPE ty_internal_message,
          lt_bdcmsgcoll TYPE STANDARD TABLE OF bdcmsgcoll WITH DEFAULT KEY,
          lt_bapiret2   TYPE bapiret2_t.

    lt_bdcmsgcoll = messages.

    CALL FUNCTION 'CONVERT_BDCMSGCOLL_TO_BAPIRET2'
      TABLES
        imt_bdcmsgcoll = lt_bdcmsgcoll
        ext_return     = lt_bapiret2.

    LOOP AT lt_bapiret2 ASSIGNING <fs_bapiret2>.
      MOVE-CORRESPONDING <fs_bapiret2> TO ls_internal.
      APPEND ls_internal TO et_internal.
      CLEAR ls_internal.
    ENDLOOP.

  ENDMETHOD.                    "mapping_to_internal

ENDCLASS.                    "lcl_messages_bdcmsgcoll_t IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_string IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_string IMPLEMENTATION.

  METHOD mapping_to_internal.

    DATA: ls_internal TYPE ty_internal_message,
          lv_messages TYPE string.

    IF iv_msgty IS INITIAL.
      ls_internal-type = get_default_msg_type( ).
    ELSE.
      ls_internal-type = iv_msgty.
    ENDIF.

    lv_messages = messages.

    add_string_to_internal(
      EXPORTING
        string      = lv_messages
        is_message  = ls_internal
      IMPORTING
        et_messages = et_internal ).

  ENDMETHOD.                    "mapping_to_internal

ENDCLASS.                    "lcl_messages_string IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_bapiret2 IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bapiret2 IMPLEMENTATION.
  METHOD mapping_to_internal.

    DATA: ls_bapiret2 TYPE bapiret2,
          ls_internal TYPE ty_internal_message.

    ls_bapiret2 = messages.
    IF ls_bapiret2 IS INITIAL.
      RETURN.
    ENDIF.
    IF ls_bapiret2-type IS INITIAL.
      ls_bapiret2-type = get_default_msg_type( ).
    ENDIF.
    MOVE-CORRESPONDING ls_bapiret2 TO ls_internal.
    APPEND ls_internal TO et_internal.

  ENDMETHOD.                    "mapping_to_internal

  METHOD mapping_to_external.

    DATA:
      lt_messages TYPE ty_t_internal_message,
      ls_message  TYPE ty_internal_message,
      ls_bapiret2 TYPE bapiret2.

    get_mt_messages(
      IMPORTING
        et_messages = lt_messages ).

    READ TABLE lt_messages INTO ls_message INDEX 1.
    IF sy-subrc IS INITIAL.

      mapping_internal_to_bapiret2(
        EXPORTING
          is_internal = ls_message
        IMPORTING
          es_external = ls_bapiret2 ).
    ENDIF.

    messages = ls_bapiret2.

  ENDMETHOD.                    "mapping_to_external
ENDCLASS.                    "lcl_messages_bapiret2 IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS lcl_messages_bapiret2_t IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bapiret2_t IMPLEMENTATION.
  METHOD mapping_to_internal.

    FIELD-SYMBOLS : <fs_bapiret2>   TYPE bapiret2.

    DATA: lt_bapiret2 TYPE bapiret2_t,
          ls_internal TYPE ty_internal_message.

    lt_bapiret2 = messages.
    LOOP AT lt_bapiret2 ASSIGNING <fs_bapiret2>.
      IF <fs_bapiret2>-type IS INITIAL.
        <fs_bapiret2>-type = get_default_msg_type( ).
      ENDIF.
      MOVE-CORRESPONDING <fs_bapiret2> TO ls_internal.
      APPEND ls_internal TO et_internal.
      CLEAR ls_internal.
    ENDLOOP.

  ENDMETHOD.                    "mapping_to_internal

  METHOD mapping_to_external.

    DATA:
      lt_messages TYPE ty_t_internal_message,
      ls_message  TYPE ty_internal_message,
      lt_bapiret2 TYPE bapiret2_t,
      ls_bapiret2 TYPE bapiret2.

    get_mt_messages(
      IMPORTING
        et_messages = lt_messages ).

    LOOP AT lt_messages INTO ls_message.

      mapping_internal_to_bapiret2(
        EXPORTING
          is_internal = ls_message
        IMPORTING
          es_external = ls_bapiret2 ).

      APPEND ls_bapiret2 TO lt_bapiret2.
      CLEAR ls_bapiret2.

    ENDLOOP.

    messages = lt_bapiret2.

  ENDMETHOD.                    "mapping_to_external

ENDCLASS.                    "lcl_messages_bapiret2_t IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_type DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_type DEFINITION.

  PUBLIC SECTION.
    TYPES: ty_way(1) TYPE c.
    CLASS-METHODS: factory IMPORTING iv_way      TYPE ty_way
                                     messages    TYPE any
                           CHANGING  ci_messages TYPE REF TO lif_messages_internal
                           RAISING   cx_sy_move_cast_error,
      class_constructor.

  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_ref_routing,
        way        TYPE ty_way,
        type_kind  TYPE abap_typekind,
        type_name  TYPE string,
        class_name TYPE string,
      END OF ty_ref_routing,
      ty_t_ref_routing TYPE HASHED TABLE OF ty_ref_routing WITH UNIQUE KEY way type_kind type_name.
    CLASS-METHODS:
      get_messages_type_n_name   IMPORTING messages     TYPE any
                                 EXPORTING ev_type_name TYPE string
                                           ev_type_kind TYPE abap_typekind
                                 RAISING   cx_sy_move_cast_error,
      get_table_type_descr      IMPORTING io_tabledescr TYPE REF TO cl_abap_tabledescr
                                EXPORTING eo_typedescr  TYPE REF TO cl_abap_typedescr
                                RAISING   cx_sy_move_cast_error,

      instance_narrowing IMPORTING iv_way       TYPE ty_way
                                   iv_type_name TYPE string
                                   iv_type_kind TYPE abap_typekind
                         CHANGING  ci_messages  TYPE REF TO lif_messages_internal
                         RAISING   cx_sy_move_cast_error,
      get_routing_ref    IMPORTING iv_way         TYPE ty_way
                                   iv_type_name   TYPE string
                                   iv_type_kind   TYPE abap_typekind
                         CHANGING  cs_routing_ref TYPE ty_ref_routing
                         RAISING   cx_sy_move_cast_error,
      get_exception_routing_ref
        IMPORTING iv_way         TYPE ty_way
                  iv_type_name   TYPE string
                  iv_type_kind   TYPE abap_typekind
        CHANGING  cs_routing_ref TYPE ty_ref_routing
        RAISING   cx_sy_move_cast_error.

    CLASS-DATA: mth_routing_ref TYPE ty_t_ref_routing.
ENDCLASS.                    "lcl_messages_type DEFINITION


*----------------------------------------------------------------------*
*       CLASS lcl_messages_type IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_type IMPLEMENTATION.

  METHOD class_constructor.
    DATA ls_routing_ref TYPE ty_ref_routing.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_table.
    ls_routing_ref-type_name  = 'BAPIRET2'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BAPIRET2_T'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.
    ls_routing_ref-way        = 'O'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_table.
    ls_routing_ref-type_name  = 'BAPIRET1'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BAPIRET1_T'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_table.
    ls_routing_ref-type_name  = 'BDCMSGCOLL'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BDCMSGCOLL_T'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_struct1.
    ls_routing_ref-type_name  = 'BAPIRET2'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BAPIRET2'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.
    ls_routing_ref-way        = 'O'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_struct1.
    ls_routing_ref-type_name  = 'BAPIRET1'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BAPIRET1'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_struct1.
    ls_routing_ref-type_name  = 'SYST'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_SYSTEM'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_string.
    ls_routing_ref-type_name  = 'STRING'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_STRING'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_char.
    ls_routing_ref-type_name  = ''.
    ls_routing_ref-class_name = 'LCL_MESSAGES_STRING'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_oref.
    ls_routing_ref-type_name  = 'IF_MESSAGE'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_IF_MESSAGE'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_oref.
    ls_routing_ref-type_name  = 'LIF_MESSAGES'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_LIF_MESSAGES'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'O'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_table.
    ls_routing_ref-type_name  = 'BAL_S_MSG'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BAL_T_MSG'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.
    ls_routing_ref-way        = 'I'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'O'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_struct2.
    ls_routing_ref-type_name  = 'BAL_S_MSG'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BAL_S_MSG'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.
    ls_routing_ref-way        = 'I'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'O'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_char.
    ls_routing_ref-type_name  = 'BALLOGHNDL'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BALLOGHNDL'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

    ls_routing_ref-way        = 'I'.
    ls_routing_ref-type_kind  = cl_abap_typedescr=>typekind_char.
    ls_routing_ref-type_name  = 'BALLOGHNDL'.
    ls_routing_ref-class_name = 'LCL_MESSAGES_BALLOGHNDL'.
    INSERT ls_routing_ref INTO TABLE mth_routing_ref.

  ENDMETHOD.                    "class_constructor
  METHOD get_messages_type_n_name.

    DATA: lo_typedescr TYPE REF TO cl_abap_typedescr,
          lo_tabdescr  TYPE REF TO cl_abap_tabledescr,
          lo_refdescr  TYPE REF TO cl_abap_refdescr,
          lo_data      TYPE REF TO data.

    GET REFERENCE OF messages INTO lo_data.

    lo_typedescr ?= cl_abap_typedescr=>describe_by_data_ref( lo_data ).
    ev_type_kind = lo_typedescr->type_kind.

    CASE lo_typedescr->type_kind.

      WHEN cl_abap_typedescr=>typekind_table.
        lo_tabdescr ?= lo_typedescr.
        get_table_type_descr( EXPORTING io_tabledescr = lo_tabdescr
                              IMPORTING eo_typedescr  = lo_typedescr ).
      WHEN cl_abap_typedescr=>typekind_struct1
        OR cl_abap_typedescr=>typekind_struct2.
      WHEN cl_abap_typedescr=>typekind_char
      OR   cl_abap_typedescr=>typekind_string.

      WHEN cl_abap_typedescr=>typekind_oref.

        lo_refdescr ?= lo_typedescr.
        lo_typedescr ?= lo_refdescr->get_referenced_type( ).

      WHEN OTHERS.
        CLEAR ev_type_kind.
        RETURN.
    ENDCASE.

    ev_type_name = lo_typedescr->get_relative_name( ).

  ENDMETHOD.                    "get_messages_type_n_name

  METHOD get_table_type_descr.

    DATA:
      lo_strucdescr TYPE REF TO cl_abap_structdescr,
      lo_elemdescr  TYPE REF TO cl_abap_elemdescr,
      lo_refdescr   TYPE REF TO cl_abap_refdescr.

    eo_typedescr = io_tabledescr->get_table_line_type( ).

    TRY.
        lo_strucdescr ?= eo_typedescr.
      CATCH cx_sy_move_cast_error.
        TRY.
            lo_elemdescr ?= eo_typedescr.
          CATCH cx_sy_move_cast_error.
            TRY.
                lo_refdescr ?= eo_typedescr.
              CATCH cx_sy_move_cast_error.
            ENDTRY.
        ENDTRY.
    ENDTRY.

  ENDMETHOD.                    "get_table_type_descr

  METHOD get_routing_ref.
    READ TABLE mth_routing_ref INTO cs_routing_ref WITH TABLE KEY way       = iv_way
                                                                  type_kind = iv_type_kind
                                                                  type_name = iv_type_name.
    IF NOT sy-subrc IS INITIAL.
      RAISE EXCEPTION TYPE cx_sy_move_cast_error.
    ENDIF.

  ENDMETHOD.
  METHOD get_exception_routing_ref.

    DATA: lv_type_name TYPE string,
          lv_type_kind TYPE abap_typekind.

    IF iv_way = 'I'.
      IF iv_type_name = ''.
        lv_type_name  = 'SYST'.
        lv_type_kind  = cl_abap_typedescr=>typekind_struct1.
      ELSEIF iv_type_name CS 'CX_'
          OR iv_type_name CS 'ZCX_'
          OR iv_type_name CS 'LCX_'.
        lv_type_name  = 'IF_MESSAGE'.
        lv_type_kind  = cl_abap_typedescr=>typekind_oref.
      ELSE.
        RAISE EXCEPTION TYPE cx_sy_move_cast_error.
      ENDIF.
      get_routing_ref(
        EXPORTING
          iv_way                = iv_way
          iv_type_name          = lv_type_name
          iv_type_kind          = lv_type_kind
        CHANGING
          cs_routing_ref        = cs_routing_ref ).

    ELSE.
      RAISE EXCEPTION TYPE cx_sy_move_cast_error.
    ENDIF.

  ENDMETHOD.

  METHOD instance_narrowing.

    DATA : li_messages    TYPE REF TO lif_messages_internal,
           ls_routing_ref TYPE ty_ref_routing.

    TRY .
        get_routing_ref(
          EXPORTING
            iv_way                = iv_way
            iv_type_name          = iv_type_name
            iv_type_kind          = iv_type_kind
          CHANGING
            cs_routing_ref        = ls_routing_ref ).
      CATCH cx_sy_move_cast_error.
        get_exception_routing_ref(
          EXPORTING
            iv_way                = iv_way
            iv_type_name          = iv_type_name
            iv_type_kind          = iv_type_kind
          CHANGING
            cs_routing_ref        = ls_routing_ref ).
    ENDTRY.

    IF ls_routing_ref-class_name IS INITIAL.
      RAISE EXCEPTION TYPE cx_sy_move_cast_error.
    ENDIF.

    CREATE OBJECT li_messages TYPE (ls_routing_ref-class_name).
    li_messages->copy( ci_messages ).
    ci_messages = li_messages.

  ENDMETHOD.                    "instance_narrowing
  METHOD factory.

    DATA: lv_type_name TYPE string,
          lv_type_kind TYPE abap_typekind.

    get_messages_type_n_name(
      EXPORTING
        messages              = messages
      IMPORTING
        ev_type_name          = lv_type_name
        ev_type_kind          = lv_type_kind ).

    instance_narrowing(
      EXPORTING
        iv_way                = iv_way
        iv_type_name          = lv_type_name
        iv_type_kind          = lv_type_kind
      CHANGING
        ci_messages           = ci_messages ).
*      CATCH cx_sy_move_cast_error.    "

  ENDMETHOD.                    "factory
ENDCLASS.                    "lcl_messages_type IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS  lcl_messages IMPLEMENTATION.
  METHOD lif_messages~add_n_raise.
    add_n_raise( EXPORTING messages = messages
                           iv_msgty = iv_msgty ).
  ENDMETHOD.                    "lif_messages~add_n_raise
  METHOD lif_messages~set_current_context.
    set_current_context( is_current_context ).
  ENDMETHOD.
  METHOD lif_messages~set_current_params.
    set_current_params( is_current_params ).
  ENDMETHOD.
  METHOD lif_messages~get_current_context.
    rs_current_context = get_current_context( ).
  ENDMETHOD.
  METHOD lif_messages~get_current_params.
    rs_current_params = get_current_params( ).
  ENDMETHOD.
  METHOD lif_messages~add.
    add( EXPORTING messages = messages
                   iv_msgty = iv_msgty ).
  ENDMETHOD.                    "lif_messages~add
  METHOD lif_messages~get.
    get( IMPORTING messages = messages ).
  ENDMETHOD.                    "lif_messages~get
  METHOD lif_messages~set_current_level     .
    set_current_level( iv_current_level ).
  ENDMETHOD.                    "lif_messages~set_current_level
  METHOD lif_messages~set_current_probclass .
    set_current_probclass( iv_current_probclass ).
  ENDMETHOD.                    "lif_messages~set_current_probclass
  METHOD lif_messages~get_current_level     .
    rv_current_level = get_current_level( ).
  ENDMETHOD.                    "lif_messages~get_current_level
  METHOD lif_messages~get_current_probclass .
    rv_current_probclass = get_current_probclass( ).
  ENDMETHOD.                    "lif_messages~get_current_probclass
  METHOD lif_messages~get_messages_count.
    rv_count = get_messages_count( ).
  ENDMETHOD.                    "lif_messages~get_messages_count
  METHOD set_current_level     .
    mi_messages->set_current_level( iv_current_level ).
  ENDMETHOD.                    "set_current_level
  METHOD set_current_probclass .
    mi_messages->set_current_probclass( iv_current_probclass ).
  ENDMETHOD.                    "set_current_probclass
  METHOD get_current_level     .
    rv_current_level = mi_messages->get_current_level( ).
  ENDMETHOD.                    "get_current_level
  METHOD get_current_probclass .
    rv_current_probclass = mi_messages->get_current_probclass( ).
  ENDMETHOD.                    "get_current_probclass
  METHOD set_default_msg_type.
    mi_messages->set_default_msg_type( iv_default_msg_type ).
  ENDMETHOD.                    "set_default_msg_type
  METHOD get_severity.
    rv_severity = mi_messages->get_severity( ).
  ENDMETHOD.                    "get_severity
  METHOD get_integer_severity.
    rv_severity = mi_messages->get_integer_severity( ).
  ENDMETHOD.
  METHOD get_messages_count.
    rv_count = mi_messages->get_messages_count( ).
  ENDMETHOD.                    "get_messages_count
  METHOD set_current_context.
    mi_messages->set_current_context( is_current_context ).
  ENDMETHOD.
  METHOD set_current_params.
    mi_messages->set_current_params( is_current_params ).
  ENDMETHOD.
  METHOD get_current_context.
    rs_current_context = mi_messages->get_current_context( ).
  ENDMETHOD.
  METHOD to_string.
    rv_messages = mi_messages->to_string( ).
  ENDMETHOD.
  METHOD get_current_params.
    rs_current_params = mi_messages->get_current_params( ).
  ENDMETHOD.
  METHOD lif_messages~to_string.
    rv_messages = to_string( ).
  ENDMETHOD.
  METHOD get_default_msg_type.
    rv_default_msg_type = mi_messages->get_default_msg_type( ).
  ENDMETHOD.                    "get_default_msg_type
  METHOD increase_current_level.
    DATA lv_current_level TYPE ballevel.
    lv_current_level = get_current_level( ).
    IF lv_current_level = 10.
      RETURN.
    ELSE.
      lv_current_level = lv_current_level + 1.
      set_current_level( lv_current_level ).
    ENDIF.
  ENDMETHOD.                    "increase_current_level
  METHOD decrease_current_level.
    DATA lv_current_level TYPE ballevel.
    lv_current_level = get_current_level( ).
    IF lv_current_level = 1.
      RETURN.
    ELSE.
      lv_current_level = lv_current_level - 1.
      set_current_level( lv_current_level ).
    ENDIF.
  ENDMETHOD.                    "decrease_current_level
  METHOD lif_messages~decrease_current_level.
    decrease_current_level( ).
  ENDMETHOD.                    "lif_messages~decrease_current_level
  METHOD lif_messages~increase_current_level.
    increase_current_level( ).
  ENDMETHOD.                    "lif_messages~increase_current_level
  METHOD lif_messages~get_severity.
    rv_severity = get_severity( ).
  ENDMETHOD.                    "lif_messages~get_severity
  METHOD lif_messages~get_integer_severity.
    rv_severity = get_integer_severity( ).
  ENDMETHOD.                    "lif_messages~get_severity
  METHOD lif_messages~set_default_msg_type.
    set_default_msg_type( iv_default_msg_type ).
  ENDMETHOD.                    "lif_messages~set_default_msg_type
  METHOD lif_messages~get_default_msg_type.
    rv_default_msg_type = get_default_msg_type( ).
  ENDMETHOD.                    "lif_messages~get_default_msg_type
  METHOD constructor.
    CREATE OBJECT mi_messages TYPE lcl_messages_internal.
  ENDMETHOD.                    "constructor
  METHOD lif_messages~clear.
    clear( ).
  ENDMETHOD.                    "lif_messages~clear
  METHOD clear.
    mi_messages->clear( ).
  ENDMETHOD.                    "clear
  METHOD add.
    lcl_messages_type=>factory(
      EXPORTING
        iv_way      = 'I'
        messages    = messages
      CHANGING
        ci_messages = mi_messages ).
*      " we raise exception deliberately
*      CATCH cx_sy_move_cast_error.

    mi_messages->add(
        messages = messages
        iv_msgty = iv_msgty ).

  ENDMETHOD.                    "add

  METHOD add_n_raise.
    lcl_messages_type=>factory(
      EXPORTING
        iv_way      = 'I'
        messages    = messages
      CHANGING
        ci_messages = mi_messages ).
*      " we raise exception deliberately
*      CATCH cx_sy_move_cast_error.

    mi_messages->add_n_raise(
        messages = messages
        iv_msgty = iv_msgty ).

  ENDMETHOD.                    "add_n_raise
  METHOD get.
    lcl_messages_type=>factory(
      EXPORTING
        iv_way      = 'O'
        messages    = messages
      CHANGING
        ci_messages = mi_messages ).
*      " we raise exception deliberately
*      CATCH cx_sy_move_cast_error.

    mi_messages->get(
      IMPORTING
        messages = messages ).

  ENDMETHOD.                    "get

ENDCLASS.                    "lcl_messages IMPLEMENTATION

CLASS lcl_ballog  IMPLEMENTATION.


  METHOD lif_log~get_display_profile.
    rs_display_profile = get_display_profile( ).
  ENDMETHOD.
  METHOD lif_log~set_display_profile.
    set_display_profile( is_display_profile = is_display_profile ).
  ENDMETHOD.

  METHOD lif_log~create.
    create(
        is_log = is_log
    ).
  ENDMETHOD.
  METHOD lif_log~add_messages.
    add_messages( ii_messages ).
  ENDMETHOD.
  METHOD lif_log~save.
    save( ).
  ENDMETHOD.
  METHOD lif_log~get_log_handle.
    rv_log_handle = get_log_handle( ).
  ENDMETHOD.

  METHOD lif_log~display.
    display( iv_raise_if_one_message ).
  ENDMETHOD.

  METHOD get_display_profile.
    rs_display_profile = ms_display_profile.
  ENDMETHOD.
  METHOD set_display_profile.
    ms_display_profile = is_display_profile.
  ENDMETHOD.

  METHOD add_messages.
    IF mv_log_handle IS INITIAL.
      create( ).
*      CATCH lcx_error_occurs.    "
    ENDIF.
    ii_messages->get( IMPORTING messages = mv_log_handle ).
    mi_messages->add( ii_messages ).
  ENDMETHOD.                    "add_messages
  METHOD constructor.
    mi_messages = lcl_messages_factory=>get_instance( ).
  ENDMETHOD.
  METHOD display.

    DATA :
      lt_log_handle      TYPE bal_t_logh,
      ls_display_profile TYPE bal_s_prof,
      ls_return          TYPE bapiret2.

    IF mv_log_handle IS INITIAL.
      RETURN.
    ENDIF.

    IF mi_messages->get_messages_count( ) = 1
    AND iv_raise_if_one_message = abap_true.

      mi_messages->get(
        IMPORTING
          messages = ls_return ).
      IF NOT ls_return IS INITIAL.
        MESSAGE ID ls_return-id
        TYPE ls_return-type
        NUMBER ls_return-number
        WITH  ls_return-message_v1
              ls_return-message_v2
              ls_return-message_v3
              ls_return-message_v4.
      ENDIF.

    ELSE.

      ls_display_profile = get_display_profile( ).

      APPEND mv_log_handle TO lt_log_handle.
      CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
        EXPORTING
          i_s_display_profile  = ls_display_profile
          i_t_log_handle       = lt_log_handle
        EXCEPTIONS
          profile_inconsistent = 1
          internal_error       = 2
          no_data_available    = 3
          no_authority         = 4
          OTHERS               = 5.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE lcx_error_occurs.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "display
  METHOD save.
    DATA :
          lt_log_handle TYPE bal_t_logh.

    APPEND mv_log_handle TO lt_log_handle.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
*       I_CLIENT         = SY-MANDT
*       I_IN_UPDATE_TASK = ' '
*       I_SAVE_ALL       = ' '
        i_t_log_handle   = lt_log_handle
*       I_2TH_CONNECTION = ' '
*       I_2TH_CONNECT_COMMIT       = ' '
*       I_LINK2JOB       = 'X'
*     IMPORTING
*       E_NEW_LOGNUMBERS =
*       E_SECOND_CONNECTION        =
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        OTHERS           = 4.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE lcx_error_occurs.
    ENDIF.

  ENDMETHOD.                    "save
  METHOD get_log_handle.
    rv_log_handle = mv_log_handle.
  ENDMETHOD.                    "get_log_handle
  METHOD create.

    DATA : ls_log TYPE bal_s_log.

    " already created
    IF NOT mv_log_handle IS INITIAL.
      RETURN.
    ENDIF.

    IF NOT is_log IS INITIAL.
      ls_log = is_log.
    ENDIF.

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = ls_log
      IMPORTING
        e_log_handle            = mv_log_handle
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE lcx_error_occurs.
    ENDIF.


  ENDMETHOD.                    "create


ENDCLASS.

*----------------------------------------------------------------------*
*       CLASS lcl_messages_displayer IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_displayer  IMPLEMENTATION.

  METHOD lif_messages_displayer~display_messages.
    display_messages( EXPORTING ii_messages = ii_messages
                                iv_raise_if_one_message = iv_raise_if_one_message ).
  ENDMETHOD.                    "lif_log~display_messages
  METHOD display_messages.

    DATA ls_return TYPE bapiret2.

    IF ii_messages IS SUPPLIED.
      mi_log->add_messages( ii_messages ).
*      CATCH lcx_error_occurs.    "
    ENDIF.

    mi_log->display(
        iv_raise_if_one_message = iv_raise_if_one_message
    ).
*      CATCH lcx_error_occurs.    "

  ENDMETHOD.                    "display_messages

  METHOD constructor.
    mi_log = ii_log.
  ENDMETHOD.
ENDCLASS.                    "lcl_messages_displayer IMPLEMENTATION


*----------------------------------------------------------------------*
*       CLASS lcl_messages_displayer_popup IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_displayer_popup IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ii_log = ii_log ).
    CALL FUNCTION 'BAL_DSP_PROFILE_POPUP_GET'
      IMPORTING
        e_s_display_profile = ms_display_profile.
    ii_log->set_display_profile( ms_display_profile ).
  ENDMETHOD.
ENDCLASS.                    "lcl_messages_displayer_popup IMPLEMENTATION


CLASS lcl_messages_displayer_std IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ii_log = ii_log ).
    CALL FUNCTION 'BAL_DSP_PROFILE_STANDARD_GET'
      IMPORTING
        e_s_display_profile = ms_display_profile.
    ii_log->set_display_profile( ms_display_profile ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_messages_displayer_sgl_log IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ii_log = ii_log ).
    CALL FUNCTION 'BAL_DSP_PROFILE_SINGLE_LOG_GET'
      IMPORTING
        e_s_display_profile = ms_display_profile.
    ii_log->set_display_profile( ms_display_profile ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_messages_displayer_no_tree IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ii_log = ii_log ).
    CALL FUNCTION 'BAL_DSP_PROFILE_NO_TREE_GET'
      IMPORTING
        e_s_display_profile = ms_display_profile.
    ii_log->set_display_profile( ms_display_profile ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_messages_displayer_detlevl IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ii_log = ii_log ).
    CALL FUNCTION 'BAL_DSP_PROFILE_DETLEVEL_GET'
      IMPORTING
        e_s_display_profile = ms_display_profile.
    ii_log->set_display_profile( ms_display_profile ).
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------------------------------*
*       CLASS lcl_messages_factory IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_factory IMPLEMENTATION.

  METHOD get_instance.
    CREATE OBJECT ri_messages TYPE lcl_messages.
  ENDMETHOD.                    "get_instance

ENDCLASS.                    "lcl_messages_factory IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_displayer_factory IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_displayer_factory IMPLEMENTATION.

  METHOD get_instance.

    DATA li_log TYPE REF TO lif_log.

    TRY.
        li_log = lcl_log_factory=>get_instance( iv_log_type ).
      CATCH lcx_error_occurs.

    ENDTRY.

    CASE iv_display_type.
      WHEN c_display_type-popup.
        CREATE OBJECT ri_messages_displayer
          TYPE lcl_messages_displayer_popup
          EXPORTING
            ii_log = li_log.
      WHEN c_display_type-standard.
        CREATE OBJECT ri_messages_displayer
          TYPE lcl_messages_displayer_std
          EXPORTING
            ii_log = li_log.
      WHEN c_display_type-single_log.
        CREATE OBJECT ri_messages_displayer
          TYPE lcl_messages_displayer_sgl_log
          EXPORTING
            ii_log = li_log.
      WHEN c_display_type-no_tree.
        CREATE OBJECT ri_messages_displayer
          TYPE lcl_messages_displayer_no_tree
          EXPORTING
            ii_log = li_log.
      WHEN c_display_type-detail_level.
        CREATE OBJECT ri_messages_displayer
          TYPE lcl_messages_displayer_detlevl
          EXPORTING
            ii_log = li_log.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE lcx_error_occurs.
    ENDCASE.
  ENDMETHOD.                    "get_instance

ENDCLASS.

CLASS lcl_log_factory IMPLEMENTATION.
  METHOD get_instance.
    CASE iv_log_type.
      WHEN c_log_type-ballog.
        CREATE OBJECT ri_log TYPE lcl_ballog.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE lcx_error_occurs.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
