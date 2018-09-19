header {
package edu.mit.compilers.grammar;
}

options
{
  mangleLiteralPrefix = "TK_";
  language = "Java";
}

class DecafParser extends Parser;
options
{
  importVocab = DecafScanner;
  k = 3;
  buildAST = true;
}

// Java glue code that makes error reporting easier.
// You can insert arbitrary Java code into your parser/lexer this way.
{
  // Do our own reporting of errors so the parser can return a non-zero status
  // if any errors are detected.
  /** Reports if any errors were reported during parse. */
  private boolean error;

  @Override
  public void reportError (RecognitionException ex) {
    // Print the error via some kind of error reporting mechanism.
    error = true;
  }
  @Override
  public void reportError (String s) {
    // Print the error via some kind of error reporting mechanism.
    error = true;
  }
  public boolean getError () {
    return error;
  }

  // Selectively turns on debug mode.

  /** Whether to display debug information. */
  private boolean trace = false;

  public void setTrace(boolean shouldTrace) {
    trace = shouldTrace;
  }
  @Override
  public void traceIn(String rname) throws TokenStreamException {
    if (trace) {
      super.traceIn(rname);
    }
  }
  @Override
  public void traceOut(String rname) throws TokenStreamException {
    if (trace) {
      super.traceOut(rname);
    }
  }
}

//program: TK_class ID LCURLY RCURLY EOF;
program: (import_decl)* (field_decl)* (method_decl)* EOF;
import_decl: TK_import ID SEMI;
field_decl: type (ID | ID LSQPAREN INTLITERAL RSQPAREN )+ COMMA SEMI;
method_decl: (type | TK_void) ID LPAREN ((type ID)+ COMMA)? RPAREN block;
block: LCURLY (field_decl)* (statement)* RCURLY;
type: (TK_int | TK_bool);
statement: (location assign_expr SEMI | 
           method_call SEMI | 
           TK_if LPAREN expr RPAREN (TK_else block)? |
           TK_for LPAREN ID EQ expr SEMI expr SEMI location (compound_assign_op expr | increment) RPAREN block |
           TK_while LPAREN expr RPAREN block | 
           TK_break SEMI |
           TK_continue SEMI);
assign_expr: (assign_op expr | increment);
assign_op: (EQ | compound_assign_op);
compound_assign_op: (PlusEq | MinusEq);
increment: (PlusPlus | MinusMinus);
//method_call: (method_name LPAREN ((expr)+ COMMA)? RPAREN | 
method_call: method_name LPAREN ((import_arg)+ COMMA)? RPAREN;
method_name: ID; 
location: (ID | ID LSQPAREN expr RSQPAREN);
expr: location;
//expr: (location | 
//       method_call | 
//        literal | 
//        TK_len LPAREN ID RPAREN | 
//        expr binop expr |
//        Minus expr |
//        Exclam expr | 
//        LPAREN expr RPAREN | 
//        expr Ques expr Colon expr);
import_arg: (expr | STRING);

binop : (arithop | relop | eqop | condop);
        
arithop: (Plus | Minus | Mult | Div | Mod);
relop : (Greater | Less | Geq | Leq);
eqop: (Eq | Neq);
condop : (And | Or);
literal: (INTLITERAL | CHAR | boolliteral);
//id in lexer
//alphanum in lexer
//digit in lexer
//hex_digit in lexer
//int_literal in lexer
//decimal literal in lexer
boolliteral: (TRUE | FALSE);
//charliteral in lexer
//stringliteral in lexer

