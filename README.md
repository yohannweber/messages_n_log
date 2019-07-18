# messages_n_log
Manage messages more easily

# Features
This project contains three tools :
## The messages repository class
It helps developper to store/retrieve messages from different sources types in one instruction.

### Storage messages example
```abap
DATA li_messages TYPE REF TO lif_messages.
DATA lt_messages TYPE STANDARD TABLE OF bapiret2.
DATA ls_messages TYPE bapiret2.
DATA ls_bdcmsgcoll TYPE bdcmsgcoll.
DATA lx_error_occurs TYPE REF TO lcx_error_occurs.

"...

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
|This is a very long string| &&
|with many...| &&
|many...| &&
|lines.| ).

" append message from exception
li_messages->add( lx_error_occurs ).
```
In the same way, it provides a one instruction effort to retrieve all the messages into a target type.

### Retrieve messages example
```abap
"...
DATA lt_ballog TYPE bal_t_msg.
li_messages->get( IMPORTING messages = lt_ballog ).

DATA lt_messages TYPE STANDARD TABLE OF bapiret2.
li_messages->get( IMPORTING messages = lt_messages ).
```

## The log messages manager class
It helps create/save/display messages from LIF_MESSAGES using BAL_LOG

## The log messages displayer class
It helps create/display messages from LIF_MESSAGES using BAL_LOG

# Installation
Create 2 includes by copy of MESSAGE_DEF and MESSAGE_IMP files.
Then you can include them directly in your program.

# Examples
You can find examples in the file MESSAGES_N_LOG_SAMPLE

# Contribute
- Issue Tracker: https://github.com/yohannweber/messages_n_log/issues
- Source Code: https://github.com/yohannweber/messages_n_log

# License
The project is licensed under the BSD license.
