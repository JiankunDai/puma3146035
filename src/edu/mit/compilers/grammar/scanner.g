header {
package edu.mit.compilers.grammar;
}

options
{
  mangleLiteralPrefix = "TK_";
  language = "Java";
}

{@SuppressWarnings("unchecked")}
class DecafScanner extends Lexer;
options
{
  k = 2;
}

tokens 
{
  "class";
  "bool";
  "break";
  "continue";
  "else";
  "import";
  FALSE = "false";
  "for";
  "while";
  "if";
  "int";
  "return";
  "len";
  TRUE = "true";
  "void";
}

// Selectively turns on debug tracing mode.
// You can insert arbitrary Java code into your parser/lexer this way.
{
  /** Whether to display debug information. */
  private boolean trace = false;

  public void setTrace(boolean shouldTrace) {
    trace = shouldTrace;
  }
  @Override
  public void traceIn(String rname) throws CharStreamException {
    if (trace) {
      super.traceIn(rname);
    }
  }
  @Override
  public void traceOut(String rname) throws CharStreamException {
    if (trace) {
      super.traceOut(rname);
    }
  }
}

EQ : "=";
And : "&&";
Or : "||";
Eq : "==";
Neq : "!=";
Greater : ">";
Less : "<";
Geq : ">=";
Leq : "<=";
Plus : "+";
Minus : "-";
Mult : "*";
Div : "/";
Mod : "%";
PlusPlus: "++";
MinusMinus: "--";
PlusEq: "+=";
MinusEq: "-=";

LCURLY options { paraphrase = "{"; } : "{";
RCURLY options { paraphrase = "}"; } : "}";
COMMA : ",";
LPAREN : "(";
RPAREN : ")";
LSQPAREN : "[";
RSQPAREN : "]";
SEMI : ';';

// Note that here, the {} syntax allows you to literally command the lexer
// to skip mark this token as skipped, or to advance to the next line
// by directly adding Java commands.
WS_ : (' ' | '\t' | '\n' {newline();}) {_ttype = Token.SKIP; };
SL_COMMENT : "//" (~'\n')* '\n' {_ttype = Token.SKIP; newline (); };
//BLOCK_COMMENT : '/*' .*? '*/' {_ttype = Token.SKIP; newline (); };

//CHAR : '\'' (ESC|~('\'' | '\n' | '"')) '\'';
CHAR : '\'' (ESC | ALPHA | DIGIT) '\'';
STRING : '"' (ESC|~('"' | '\''))* '"';
//STRING : '"' (CHAR)* '"';

protected ESC :  '\\' ('n'|'"'|'t'|'\\'|'\'');
protected EXCL : ~('\'' | "\n" | '"' | '\t');

protected DIGIT : '0'..'9';
protected ALPHA : ('a'..'z' | 'A'..'Z' | '_');
protected HEXDIGIT : (DIGIT | 'a'..'f' | 'A'..'F');
protected ALPHANUM : (ALPHA | DIGIT);

protected DECIMALLITERAL : DIGIT (DIGIT)*;
protected HEXLITERAL : "0x" HEXDIGIT (HEXDIGIT)*;
INTLITERAL : (DECIMALLITERAL | HEXLITERAL);
ID : ALPHA (ALPHANUM)*;
//LITERAL : (INTLITERAL | CHAR | BOOLLITERAL);


