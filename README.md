# messages_n_log
Manage messages more easily

# Features
This project contains three tools :
1. a messages repository which helps developper to store / get the message more easily. (LIF_MESSAGES) LIF_MESSAGES gives the possibility to store message from different source of message type in one instrution :

Example : 
  DATA li_messages TYPE REF TO lif_messages.
  DATA lt_messages TYPE STANDARD TABLE OF bapiret2.
  DATA ls_messages TYPE bapiret2.
  DATA ls_bdcmsgcoll TYPE bdcmsgcoll.
  
  li_messages->add( lt_messages ).
  li_messages->add( ls_messages ).
  li_messages->add( lt_messages ).
  li_messages->add( ls_bdcmsgcoll ).
  
In the same way, it provide a one instruction to get back all the messages into a target type messages.


2. a log messages manager, which helps create/save/display messages from LIF_MESSAGES using BAL_LOG
3. a log messages displayer, which helps create/display messages from LIF_MESSAGES using BAL_LOG

# Installation

Create 2 includes by copy of MESSAGE_DEF and MESSAGE_IMP files.
Then you can include them directly in your programs.

# Examples
You can find examples in the file MESSAGES_N_LOG_SAMPLE

# Contribute

- Issue Tracker: https://github.com/yohannweber/messages_n_log/issues
- Source Code: https://github.com/yohannweber/messages_n_log

# License

The project is licensed under the BSD license.
