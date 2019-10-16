*&---------------------------------------------------------------------*
*& Report  Z_MESSAGES_UTILITAIRES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT z_messages_utilitaires.


INCLUDE z_message_n_log_def.
INCLUDE z_message_n_log_imp.


START-OF-SELECTION.

  DATA: li_messages TYPE REF TO lif_messages.

*  " message container LIF_MESSAGES creation
  li_messages = lcl_messages_factory=>get_instance( ).

*  "------------------------------------------------------------
*  " Pour ajouter un message à partir de l'instruction MESSAGE
*  " ou d'un type BAPIRET2
*  " Add a message from MESSAGE instruction or BAPIRET2 type
*  "------------------------------------------------------------
  DATA: lv_dummy TYPE string.
  MESSAGE e006(/aif/bdc) INTO lv_dummy.
*  " this instruction...
  li_messages->add( sy ).
*  " ...is the same that...
  li_messages->add( ).


*  "------------------------------------------------------------
*  " Pour ajouter un message à partir d'un type BAPIRET2
*  " Add a message from BAPIRET2 type
*  "------------------------------------------------------------
  DATA:
        ls_return       TYPE bapiret2.

  ls_return-type        = 'E'.
  ls_return-id          = '/AIF/CUSTOM_FUNCTION'.
  ls_return-number      = '017'.
  ls_return-message_v1  = 'MSG_UTIL'.
  li_messages->add( ls_return ).


*  "------------------------------------------------------------
*  " Pour ajouter un message à partir d'une table de type BAPIRET2
*  " Add a message from BAPIRET2 type
*  "------------------------------------------------------------
  DATA:
    ls_poheader TYPE bapimepoheader,
    lt_return   TYPE bapiret2_t.

  CALL FUNCTION 'BAPI_PO_CREATE1'
    EXPORTING
      poheader = ls_poheader
    TABLES
      return   = lt_return.

  li_messages->add( lt_return ).


*  "------------------------------------------------------------
*  " Pour ajouter un message à partir d'un type CHAR or STRING
*  " Add a message from CHAR or STRING type
*  "------------------------------------------------------------
  DATA:
    lv_test_char_type(4) TYPE c,
    lv_test_string_type  TYPE string.

  lv_test_char_type = lv_test_string_type = 'TEST'.

  li_messages->set_default_msg_type( 'I' ).
*  " this instruction...
  li_messages->add( EXPORTING messages  = lv_test_char_type ).
*  " ...is the same that...
  li_messages->add( EXPORTING messages  = lv_test_char_type iv_msgty = 'I' ).
*  " ...and not exactly the same that
  li_messages->add( EXPORTING messages  = lv_test_string_type iv_msgty = 'E' ).


*  "------------------------------------------------------------
*  " Pour ajouter un message à partir d'un type interface IF_MESSAGE
*  " ou d'une exception
*  " Add a message from IF_MESSAGE interface type or from an exception
*  "------------------------------------------------------------
  DATA:
    lx_error_occurs TYPE REF TO lcx_error_occurs,
    li_error_occurs TYPE REF TO if_message.

  TRY .

      CREATE OBJECT lx_error_occurs.
      RAISE EXCEPTION lx_error_occurs.

    CATCH lcx_error_occurs INTO lx_error_occurs.
      li_error_occurs = lx_error_occurs.
*     " this instruction...
      li_messages->add( lx_error_occurs ).
*     " ...is the same that...

  ENDTRY.


*  "------------------------------------------------------------
*  " Pour ajouter un message à partir d'un type table BDCMSGCOLL
*  " Add a message from BDCMSGCOLL type table
*  "------------------------------------------------------------
  DATA: lt_bdcdata    TYPE STANDARD TABLE OF bdcdata    WITH DEFAULT KEY,
        lt_bdcmsgcoll TYPE STANDARD TABLE OF bdcmsgcoll WITH DEFAULT KEY.

  CALL TRANSACTION 'MM03' USING lt_bdcdata MESSAGES INTO lt_bdcmsgcoll.
  li_messages->add( lt_bdcmsgcoll ).

  DATA lt_ballog TYPE bal_t_msg.
  li_messages->get(
    IMPORTING
      messages               = lt_ballog ).

  DATA: lt_messages TYPE bapiret2_t.
  li_messages->get(
    IMPORTING
      messages               = lt_messages ).


*  "------------------------------------------------------------
*  " Quelques fonctionnalités
*  " Some fonctionalities
*  "------------------------------------------------------------

*  " get the messages count
  DATA(lv_count) = li_messages->get_messages_count( ).
  WRITE: / lv_count , ` message(s) occured`.

*  " get the messages severity
  IF li_messages->get_severity( ) = 'E'
  OR li_messages->get_severity( ) = 'A'.
    WRITE:/ 'Error message(s) occured'.
  ENDIF.

*  " get the messages integer severity
  IF li_messages->get_integer_severity( ) >= lif_messages=>c_integer_severity-error.
    WRITE: / 'Error message(s) occured'.
  ENDIF.

  " know the message severity we add
  ls_return-type        = 'E'.
  ls_return-id          = '/AIF/CUSTOM_FUNCTION'.
  ls_return-number      = '017'.
  ls_return-message_v1  = 'MSG_UTIL'.
  TRY.
      li_messages->add_n_raise( ls_return ).
    CATCH lcx_e_or_a_type_occurs.    "
      WRITE: / 'Error message(s) occured'.
  ENDTRY.



  TRY.
      " display messages from lif_messages
      DATA: li_messages_displayer TYPE REF TO lif_messages_displayer.

      li_messages_displayer = lcl_messages_displayer_factory=>get_instance(
                               iv_display_type       = lcl_messages_displayer_factory=>c_display_type-popup ).
      li_messages_displayer->display_messages( ii_messages = li_messages ).
    CATCH lcx_error_occurs.  "

  ENDTRY.

  TRY.

      DATA: li_log TYPE REF TO lif_log,
            ls_log TYPE bal_s_log.

      li_log = lcl_log_factory=>get_instance( ).
      ls_log-object    = 'ZTEST'.
      ls_log-subobject = 'MSG_N_LOG'.
      li_log->create( is_log = ls_log ).
      li_log->add_messages( ii_messages = li_messages ).
      li_log->save( ).
      li_log->display( ).

    CATCH lcx_error_occurs.  "

  ENDTRY.
