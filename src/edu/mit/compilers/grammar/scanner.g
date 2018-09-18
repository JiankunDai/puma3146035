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

//Keywords

//BOOL : "bool";
//BREAK : "break";
//IMPORT : "import";
//CONTINUE : "continue";
//ELSE : "else"; 
//protected FALSE : "false";
//FOR : "for"; 
//WHILE : "while";
//IF : "if";
//INT : "int";
//RETURN : "return";
//LEN : "len";
//protected TRUE : "true";
//VOID : "void"; 

//KEYWORD : (BOOL | BREAK | IMPORT | CONTINUE | ELSE | FOR | WHILE | IF | INT | RETURN | LEN | VOID);

EQ : "=";
protected And : "&&";
protected Or : "||";
protected Eq : "==";
protected Neq : "!=";
protected Greater : ">";
protected Less : "<";
protected Geq : ">=";
protected Leq : "<=";
protected Plus : "+";
protected Minus : "-";
protected Mult : "*";
protected Div : "/";
protected Mod : "%";

protected ARITHOP : (Plus | Minus | Mult | Div | Mod);
INCREMENT : ("++" | "--");
CONDOP : (And | Or);
EQOP : (Eq | Neq);
RELOP : (Greater | Less | Geq | Leq);
BINOP : (ARITHOP | RELOP | EQOP | CONDOP);
BOOLLITERAL : ("true" | "false");

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
WS_ : (' ' | '\n' {newline();}) {_ttype = Token.SKIP; };
SL_COMMENT : "//" (~'\n')* '\n' {_ttype = Token.SKIP; newline (); };

//CHAR : '\'' (ESC|~('\'' | '\n' | '"')) '\'';
CHAR : '\'' (ESC | ALPHA | DIGIT) '\'';
STRING : '"' (ESC|~('"' | '\''))* '"';

protected ESC :  '\\' ('n'|'"'|'t'|'\\'|'\'');

protected DIGIT : '0'..'9';
protected ALPHA : ('a'..'z' | 'A'..'Z' | '_');
protected HEXDIGIT : (DIGIT | 'a'..'f' | 'A'..'F');
protected ALPHANUM : (ALPHA | DIGIT);

protected DECIMALLITERAL : DIGIT (DIGIT)*;
protected HEXLITERAL : "0x" HEXDIGIT (HEXDIGIT)*;
INTLITERAL : (DECIMALLITERAL | HEXLITERAL);
ID : ALPHA (ALPHANUM)*;
//LITERAL : (INTLITERAL | CHAR | BOOLLITERAL);


