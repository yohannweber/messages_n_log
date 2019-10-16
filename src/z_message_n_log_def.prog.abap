*&---------------------------------------------------------------------*
*&  Include           Z_MESSAGE_N_LOG_DEF
*&---------------------------------------------------------------------*


CLASS lcx_e_or_a_type_occurs DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.                    "lcx_e_or_a_type_occurs DEFINITION
*----------------------------------------------------------------------*
*       CLASS lcx_error_occurs DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcx_error_occurs DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.                    "lcx_error_occurs DEFINITION

INTERFACE: lif_log                DEFERRED,
           lif_messages           DEFERRED,
           lif_messages_internal  DEFERRED.
CLASS:
    lcl_ballog            DEFINITION DEFERRED,
    lcl_messages_internal DEFINITION DEFERRED,
    lcl_messages          DEFINITION DEFERRED.

*----------------------------------------------------------------------*
*       INTERFACE lif_log DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_log.
  METHODS:
    create IMPORTING !is_log TYPE bal_s_log OPTIONAL
           RAISING   lcx_error_occurs,
    add_messages IMPORTING ii_messages TYPE REF TO lif_messages
                 RAISING   lcx_error_occurs,
    display IMPORTING iv_raise_if_one_message TYPE boolean DEFAULT ''
            RAISING   lcx_error_occurs,
    save RAISING   lcx_error_occurs,
    get_log_handle RETURNING VALUE(rv_log_handle) TYPE balloghndl,
    get_display_profile RETURNING VALUE(rs_display_profile) TYPE bal_s_prof,
    set_display_profile IMPORTING is_display_profile        TYPE bal_s_prof.


ENDINTERFACE.                    "lif_log DEFINITION
*----------------------------------------------------------------------*
*       INTERFACE lif_messages_displayer DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_messages_displayer.
  METHODS:
    display_messages IMPORTING !ii_messages             TYPE REF TO lif_messages
                               !iv_raise_if_one_message TYPE boolean DEFAULT ''
                     RAISING   lcx_error_occurs.


ENDINTERFACE.                    "lif_messages_displayer DEFINITION
*----------------------------------------------------------------------*
*       INTERFACE lif_messages DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_messages.
  METHODS:
    add IMPORTING !messages TYPE any DEFAULT 0
                  !iv_msgty TYPE msgty OPTIONAL
                    PREFERRED PARAMETER messages,
    add_n_raise IMPORTING !messages TYPE any   OPTIONAL
                          !iv_msgty TYPE msgty OPTIONAL
                            PREFERRED PARAMETER messages
                RAISING   lcx_e_or_a_type_occurs,
    get EXPORTING !messages TYPE any,
    set_current_level     IMPORTING !iv_current_level TYPE ballevel,
    set_current_probclass IMPORTING !iv_current_probclass TYPE balprobcl,
    get_current_level     RETURNING VALUE(rv_current_level) TYPE ballevel,
    get_current_probclass RETURNING VALUE(rv_current_probclass) TYPE balprobcl,
    set_default_msg_type  IMPORTING !iv_default_msg_type TYPE symsgty,
    get_default_msg_type  RETURNING VALUE(rv_default_msg_type) TYPE symsgty,
    get_messages_count    RETURNING VALUE(rv_count) TYPE i,
    get_severity          RETURNING VALUE(rv_severity) TYPE symsgty,
    get_integer_severity  RETURNING VALUE(rv_severity) TYPE i,
    increase_current_level,
    decrease_current_level,
    clear.

  CONSTANTS:
    BEGIN OF c_integer_severity,
      empty       TYPE i VALUE 0,
      success     TYPE i VALUE 1,
      information TYPE i VALUE 2,
      warning     TYPE i VALUE 3,
      error       TYPE i VALUE 4,
      abort       TYPE i VALUE 5,
    END OF c_integer_severity.


ENDINTERFACE.                    "lif_messages DEFINITION
*----------------------------------------------------------------------*
*       INTERFACE lif_messages_internal DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_messages_internal.
  METHODS:
    add IMPORTING !messages TYPE any
                  !iv_msgty TYPE msgty OPTIONAL,
    add_n_raise IMPORTING !messages TYPE any
                          !iv_msgty TYPE msgty OPTIONAL
                RAISING   lcx_e_or_a_type_occurs,
    get EXPORTING !messages TYPE any,
    copy IMPORTING !ii_messages TYPE REF TO lif_messages_internal,
    set_current_level     IMPORTING !iv_current_level TYPE ballevel,
    set_current_probclass IMPORTING !iv_current_probclass TYPE balprobcl,
    get_current_level     RETURNING VALUE(rv_current_level) TYPE ballevel,
    get_current_probclass RETURNING VALUE(rv_current_probclass) TYPE balprobcl,
    set_default_msg_type IMPORTING !iv_default_msg_type TYPE symsgty,
    get_default_msg_type RETURNING VALUE(rv_default_msg_type) TYPE symsgty,
    get_messages_count RETURNING VALUE(rv_count) TYPE i,
    get_severity RETURNING VALUE(rv_severity) TYPE symsgty,
    get_integer_severity  RETURNING VALUE(rv_severity) TYPE i,
    clear.


ENDINTERFACE.                    "lif_messages_internal DEFINITION

CLASS lcl_ballog DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_log.

    METHODS constructor.

  PROTECTED SECTION.
    METHODS:
      create IMPORTING !is_log TYPE bal_s_log OPTIONAL
             RAISING   lcx_error_occurs,
      save RAISING lcx_error_occurs,
      add_messages IMPORTING !ii_messages TYPE REF TO lif_messages
                   RAISING   lcx_error_occurs,
      get_log_handle RETURNING VALUE(rv_log_handle) TYPE balloghndl,
      display IMPORTING iv_raise_if_one_message TYPE boolean DEFAULT ''
              RAISING   lcx_error_occurs,
      get_display_profile RETURNING VALUE(rs_display_profile) TYPE bal_s_prof,
      set_display_profile IMPORTING is_display_profile        TYPE bal_s_prof.

    DATA: ms_display_profile TYPE bal_s_prof.

  PRIVATE SECTION.

    DATA:
      mv_log_handle TYPE balloghndl,
      mi_messages   TYPE REF TO lif_messages.

ENDCLASS.


CLASS lcl_messages_displayer DEFINITION ABSTRACT.
  PUBLIC SECTION.
    INTERFACES: lif_messages_displayer.

    METHODS constructor IMPORTING ii_log TYPE REF TO lif_log.

  PROTECTED SECTION.
    METHODS:
      display_messages IMPORTING !ii_messages             TYPE REF TO lif_messages OPTIONAL
                                 !iv_raise_if_one_message TYPE boolean DEFAULT ''
                       RAISING   lcx_error_occurs.

    DATA: ms_display_profile TYPE bal_s_prof,
          mi_log             TYPE REF TO lif_log.

  PRIVATE SECTION.


ENDCLASS.                    "lcl_messages_displayer DEFINITION



*----------------------------------------------------------------------*
*       CLASS lcl_messages_displayer_popup DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_displayer_popup DEFINITION INHERITING FROM lcl_messages_displayer.
  PUBLIC SECTION.
    METHODS constructor IMPORTING ii_log TYPE REF TO lif_log.
ENDCLASS.                    "lcl_messages_displayer_popup DEFINITION
CLASS lcl_messages_displayer_std DEFINITION INHERITING FROM lcl_messages_displayer.
  PUBLIC SECTION.
    METHODS constructor IMPORTING ii_log TYPE REF TO lif_log.
ENDCLASS.
CLASS lcl_messages_displayer_sgl_log DEFINITION INHERITING FROM lcl_messages_displayer.
  PUBLIC SECTION.
    METHODS constructor IMPORTING ii_log TYPE REF TO lif_log.
ENDCLASS.
CLASS lcl_messages_displayer_no_tree DEFINITION INHERITING FROM lcl_messages_displayer.
  PUBLIC SECTION.
    METHODS constructor IMPORTING ii_log TYPE REF TO lif_log.
ENDCLASS.
CLASS lcl_messages_displayer_detlevl DEFINITION INHERITING FROM lcl_messages_displayer.
  PUBLIC SECTION.
    METHODS constructor IMPORTING ii_log TYPE REF TO lif_log.
ENDCLASS.
*----------------------------------------------------------------------*
*       CLASS lcl_messages DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages DEFINITION.

  PUBLIC SECTION.
    INTERFACES: lif_messages.

    METHODS:
      add IMPORTING !messages TYPE any
                    !iv_msgty TYPE msgty OPTIONAL,
      add_n_raise IMPORTING !messages TYPE any
                            !iv_msgty TYPE msgty OPTIONAL
                  RAISING   lcx_e_or_a_type_occurs,
      get EXPORTING !messages TYPE any,
      set_current_level     IMPORTING !iv_current_level TYPE ballevel,
      set_current_probclass IMPORTING !iv_current_probclass TYPE balprobcl,
      get_current_level     RETURNING VALUE(rv_current_level) TYPE ballevel,
      get_current_probclass RETURNING VALUE(rv_current_probclass) TYPE balprobcl,
      set_default_msg_type IMPORTING !iv_default_msg_type TYPE symsgty,
      get_default_msg_type RETURNING VALUE(rv_default_msg_type) TYPE symsgty,
      get_messages_count RETURNING VALUE(rv_count) TYPE i,
      get_severity RETURNING VALUE(rv_severity) TYPE symsgty,
      get_integer_severity  RETURNING VALUE(rv_severity) TYPE i,
      increase_current_level,
      decrease_current_level,
      constructor,
      clear.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: mi_messages  TYPE REF TO lif_messages_internal.


ENDCLASS.                    "lcl_messages DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_factory DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_factory DEFINITION.
  PUBLIC SECTION.
    TYPES: ty_message_type(1) TYPE c.
    CONSTANTS:  BEGIN OF c_message_type,
                  default TYPE ty_message_type VALUE 'D',
                END OF c_message_type.
    CLASS-METHODS get_instance  IMPORTING !iv_message_type   TYPE ty_message_type DEFAULT c_message_type-default
                                RETURNING VALUE(ri_messages) TYPE REF TO lif_messages.

ENDCLASS.                    "lcl_messages_factory DEFINITION

CLASS lcl_log_factory DEFINITION.
  PUBLIC SECTION.
    TYPES: ty_log_type(1) TYPE c.
    CONSTANTS:  BEGIN OF c_log_type,
                  ballog TYPE ty_log_type VALUE 'B',
                END OF c_log_type.
    CLASS-METHODS get_instance IMPORTING !iv_log_type  TYPE ty_log_type DEFAULT c_log_type-ballog
                               RETURNING VALUE(ri_log) TYPE REF TO lif_log
                               RAISING   lcx_error_occurs.

ENDCLASS.


*----------------------------------------------------------------------*
*       CLASS lcl_messages_displayer_factory DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_displayer_factory DEFINITION.
  PUBLIC SECTION.
    TYPES: ty_display_type(1) TYPE c.
    CONSTANTS:  BEGIN OF c_display_type,
                  popup        TYPE ty_display_type VALUE 'P',
                  standard     TYPE ty_display_type VALUE 'S',
                  single_log   TYPE ty_display_type VALUE 'L',
                  no_tree      TYPE ty_display_type VALUE 'T',
                  detail_level TYPE ty_display_type VALUE 'D',
                END OF c_display_type.
    CLASS-METHODS get_instance IMPORTING !iv_display_type             TYPE ty_display_type DEFAULT c_display_type-popup
                                         !iv_log_type                 TYPE lcl_log_factory=>ty_log_type DEFAULT lcl_log_factory=>c_log_type-ballog
                               RETURNING VALUE(ri_messages_displayer) TYPE REF TO lif_messages_displayer
                               RAISING   lcx_error_occurs.

ENDCLASS.                    "lcl_messages_displayer_factory DEFINITION


*----------------------------------------------------------------------*
*       CLASS lcl_messages_internal DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_internal DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_messages_internal.
    METHODS :
      constructor.
  PROTECTED SECTION.
    TYPES: BEGIN OF ty_internal_message,
             type       TYPE  bapi_mtype,
             id         TYPE  symsgid,
             number     TYPE  symsgno,
             message    TYPE  bapi_msg,
             log_no     TYPE  balognr,
             log_msg_no TYPE  balmnr,
             message_v1 TYPE  symsgv,
             message_v2 TYPE  symsgv,
             message_v3 TYPE  symsgv,
             message_v4 TYPE  symsgv,
             parameter  TYPE  bapi_param,
             row        TYPE  bapi_line,
             field      TYPE  bapi_fld,
             system     TYPE  bapilogsys,
             index      TYPE  i,
             level      TYPE  ballevel,
             probclass  TYPE  balprobcl,
           END OF ty_internal_message,
           ty_t_internal_message TYPE STANDARD TABLE OF ty_internal_message WITH DEFAULT KEY.

    METHODS :
      append  IMPORTING !is_message TYPE ty_internal_message
              RAISING   lcx_e_or_a_type_occurs,
      append_t  IMPORTING it_messages TYPE ty_t_internal_message
                RAISING   lcx_e_or_a_type_occurs,
      mapping_to_internal
        IMPORTING !messages    TYPE any
                  !iv_msgty    TYPE msgty OPTIONAL
        EXPORTING !et_internal TYPE ty_t_internal_message
        RAISING   cx_sy_move_cast_error,
      mapping_to_external
        EXPORTING !messages TYPE any
        RAISING   cx_sy_move_cast_error,
      append_to_internal  IMPORTING !internal TYPE REF TO data
                          RAISING   lcx_e_or_a_type_occurs,
      copy IMPORTING !ii_messages TYPE REF TO lif_messages_internal,
      add IMPORTING !messages TYPE any
                    !iv_msgty TYPE msgty
          RAISING   lcx_e_or_a_type_occurs,
      get             EXPORTING messages TYPE any
                      RAISING   cx_sy_move_cast_error,
      mapping_internal_to_bapiret2 IMPORTING !is_internal TYPE ty_internal_message
                                   EXPORTING !es_external TYPE bapiret2,
      add_string_to_internal IMPORTING !string      TYPE string
                                       !is_message  TYPE ty_internal_message
                             EXPORTING !et_messages TYPE ty_t_internal_message,
      set_current_level IMPORTING !iv_current_level TYPE ballevel,
      set_default_msg_type IMPORTING !iv_default_msg_type TYPE symsgty,
      set_current_probclass IMPORTING !iv_current_probclass TYPE balprobcl,
      get_current_level     RETURNING VALUE(rv_current_level) TYPE ballevel,
      get_default_msg_type RETURNING VALUE(rv_default_msg_type) TYPE symsgty,
      get_current_probclass RETURNING VALUE(rv_current_probclass) TYPE balprobcl,
      get_mt_messages EXPORTING !et_messages TYPE ty_t_internal_message,
      get_messages_count RETURNING VALUE(rv_count) TYPE i,
      reset_default_values,
      adjust_severity IMPORTING !iv_severity TYPE symsgty,
      get_severity RETURNING VALUE(rv_severity) TYPE symsgty,
      get_integer_severity  RETURNING VALUE(rv_severity) TYPE i,
      clear.

  PRIVATE SECTION.

    DATA: mt_messages          TYPE ty_t_internal_message,
          mv_current_level     TYPE ballevel,
          mv_current_probclass TYPE balprobcl,
          mv_severity          TYPE symsgty,
          mv_messages_count    TYPE i,
          mv_default_msg_type  TYPE symsgty.

ENDCLASS.                    "lcl_messages_internal DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_balloghndl DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_balloghndl DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_external REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_balloghndl DEFINITION
*----------------------------------------------------------------------*
*       CLASS lcl_messages_bal_t_msg DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bal_t_msg DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_external REDEFINITION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_bal_t_msg DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_bapi_order_rtrn_t DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bapi_order_rtrn_t DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_bapi_order_rtrn_t DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_lif_messages DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_lif_messages DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_lif_messages DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_if_message DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_if_message DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_if_message DEFINITION
*----------------------------------------------------------------------*
*       CLASS lcl_messages_bdcmsgcoll_t DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bdcmsgcoll_t DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_bdcmsgcoll_t DEFINITION

CLASS lcl_messages_bapiret1 DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_messages_bapiret1_t DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.
*----------------------------------------------------------------------*
*       CLASS lcl_messages_string DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_string DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_string DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_system DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_system DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_system DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_messages_bapiret2 DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bapiret2 DEFINITION INHERITING FROM lcl_messages_internal.
  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
    METHODS mapping_to_external REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.                    "lcl_messages_bapiret2 DEFINITION
*----------------------------------------------------------------------*
*       CLASS lcl_messages_bapiret2_t DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_messages_bapiret2_t DEFINITION INHERITING FROM lcl_messages_internal.
  PROTECTED SECTION.
    METHODS mapping_to_internal REDEFINITION.
    METHODS mapping_to_external REDEFINITION.
ENDCLASS.                    "lcl_messages_bapiret2_t DEFINITION
