REPORT Z_MESSAGES_N_LOG_SAMPLE.


INCLUDE z_message_n_log_def.
INCLUDE z_message_n_log_imp.


START-OF-SELECTION.

  DATA li_messages TYPE REF TO lif_messages.

  li_messages = lcl_messages_factory=>get_instance( ).

  DATA lt_messages TYPE STANDARD TABLE OF bapiret2.
  DATA ls_messages TYPE bapiret2.
  DATA ls_bdcmsgcoll TYPE bdcmsgcoll.
  DATA lt_bdcmsgcoll TYPE STANDARD TABLE OF bdcmsgcoll WITH DEFAULT KEY.
  DATA lx_error_occurs TYPE REF TO lcx_error_occurs.
  DATA lx_error_occurs2 TYPE REF TO cx_aab_activation.

  ls_messages-id = 'ZMSG'.
  ls_messages-number = '000'.
  APPEND ls_messages TO lt_messages.
  APPEND ls_messages TO lt_messages.
  APPEND ls_messages TO lt_messages.
  APPEND ls_messages TO lt_messages.
  APPEND ls_messages TO lt_messages.
  APPEND ls_messages TO lt_messages.
  APPEND ls_messages TO lt_messages.
  CREATE OBJECT lx_error_occurs.
  CREATE OBJECT lx_error_occurs2.

  li_messages->set_default_msg_type( 'W' ).

  " append a messagefrom BAPIRET2 structure
  li_messages->add( ls_messages ).
  " append messages from BAPIRET2 table
  li_messages->add( lt_messages ).
  " append messages from BDCMSGCOLL table
  li_messages->add( lt_bdcmsgcoll ).
  " append messages from system
  li_messages->add( sy ).
  " append message from char
  li_messages->add( EXPORTING messages  = 'TEST' iv_msgty = 'I' ).
  " append message from string
  li_messages->add(
|123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890| &&
|1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123| &&
|45678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890| &&
|1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890| ).
  " append message from exception
  li_messages->add( lx_error_occurs ).
  li_messages->add( lx_error_occurs2 ).


  DATA lt_ballog TYPE bal_t_msg.
  li_messages->get(
    IMPORTING
      messages               = lt_ballog
  ).

  li_messages->get(
    IMPORTING
      messages               = lt_messages
  ).
