grammar zzz;


stmt
    :block_stmt #block
    |var_decl_stmt  #val_decl
    |expr_stmt  #expresion
    |IF '('expr')' stmt ELSE stmt #if_else
    |IF '('expr')' stmt #if
    |RETURN expr?';' #return
    |BREAK';'   #break
    |CONTINUE';'    #continue
    |WHILE '('expr')' stmt  #while
    |FOR '('expr?';' expr?';' expr?')' stmt #for
    ;

expr_stmt : expr?';';

expr : assignment_expr;

assignment_expr
    :<assoc=right>assignment_expr '=' assignment_expr
    |logic_or_expr
    ;

logic_or_expr
    :logic_or_expr '||' logic_or_expr
    | logic_and_expr
    ;

logic_and_expr
    :<assoc=right>logic_and_expr '&&' logic_and_expr
    |inclusive_or_expr
    ;

inclusive_or_expr
    :inclusive_or_expr '|' inclusive_or_expr
    |exclusive_or_expr
    ;

exclusive_or_expr
    : exclusive_or_expr '^' exclusive_or_expr
    | and_expr
    ;

and_expr
    :and_expr '&' and_expr
    |equality_expr
    ;

equality_expr
    : equality_expr op=('!='|'==') equality_expr
    | relational_expr
    ;


relational_expr
    :relational_expr op=('<'|'>'|'<='|'>=') relational_expr
    |shift_expr
    ;

shift_expr
    :shift_expr op = ('<<'|'>>') shift_expr
    |additive_expr
    ;

additive_expr
    :additive_expr op = ('+'|'-') additive_expr
    |multiplication_expr
    ;

multiplication_expr
    :multiplication_expr op = ('/'|'*'|'%') multiplication_expr
    |creation_expr
    ;


creation_expr
    :NEW type dim_expr? #new
    |unary_expr #unary_expresion
    ;

dim_expr
    :'['expr?']' #onedim
    |dim_expr '['expr?']' #multidim
    ;

unary_expr
    :postfix_expr   #postfixexpr
    |'++'unary_expr #add_addexpr
    |'--'unary_expr #minus_minusexpr
    |op = ('+'|'-'|'!'|'~') unary_expr #operatorexpr
    ;


postfix_expr
    :postfix_expr '++'  #add_add
    |postfix_expr '--'   #minus_minus
    |postfix_expr '['expr']'    #postfix_exp
    |postfix_expr '.'ID'('param_list?')' #call_mem_func
    |postfix_expr '.'ID #postfix_call_mem
    |postfix_expr '('param_list?')' #postfix_call_func
    |pre_expr #next
    ;

param_list
    :param_list ',' expr #oneexpr
    |expr   #multiexpr
    ;

pre_expr
    :BoolLiteral #pre_expr_bool
    |ID  #pre_expr_id
    |IntLiteral #pre_expr_int
    |StringLiteral #pre_expr_string
    |'('expr')' #pre_expr_expr
    |NULL #pre_expr_null
    ;

/*pre_expr
    :ID  #pre_expr_id
    |IntLiteral #pre_expr_int
    |StringLiteral #pre_expr_string
    |BoolLiteral #pre_expr_bool
    |'('expr')' #pre_expr_expr
    |NULL #pre_expr_null
    ;*/
/*fragment
StringLiteral
    :'"' SCharSequence? '"'
    ;

fragment
SCharSequence
    :   SChar+
    ;

fragment
SChar
    :   ~["\\\r\n ]
    |   EscapeSequence
    ;

fragment
EscapeSequence
    : SimpleEscapeSequence
    ;

fragment
SimpleEscapeSequence
    :   '\\' ["n\\]
    ;
*/

class_decl
    :CLASS ID '{'member_decl_list?'}'
    ;

member_decl_list
    :type ID ';' #onetypeid
    |member_decl_list type ID ';' #multitypeid
    ;


var_decl_stmt
    :type ID';' #typeid
    |type ID '=' expr';' #typeidequality
    ;

func_decl
    :type ID '(' param_decl_list? ')' block_stmt
    |'void' ID '(' param_decl_list? ')' block_stmt
    ;

param_decl_list
    :type ID  #onetype
    |param_decl_list','type ID #multitype
    ;

block_stmt
    :'{'stmt_list?'}'
    ;

stmt_list
    :stmt #onestmt
    |stmt_list stmt #multiplystmt
    ;

//program
//    :class_decl program?
//    |func_decl program?
//    |var_decl_stmt program?
//    ;

program
    :(class_decl|func_decl|var_decl_stmt)*;

WS : [ \n\t\r]+ -> skip;

COMMENT : '/*' .*? '*/' ->skip;
LineComment
    :   '//' ~[\r\n]*
        -> skip
    ;

type
    :basictype #onlyonetype
    |type '['']' #arraytype
    ;


basictype
    :INT #int
    |STRING  #string
    |BOOL #bool
    |ID #id
    ;


IF : 'if';
ELSE : 'else';
RETURN : 'return';
BREAK : 'break';
CONTINUE : 'continue';
WHILE : 'while';
FOR : 'for';
VIOD : 'void';
CLASS : 'class';
NEW : 'new';
INT : 'int';
STRING : 'string';
BOOL : 'bool';
NULL : 'null';
BoolLiteral : 'true'|'false';
IntLiteral : [0-9]+;
StringLiteral
    : '"' (EscapeSequence | .)*? '"'
    ;
ID : [a-zA-Z][0-9A-Za-z_]*;
fragment
EscapeSequence
    :'\\' [btnr"\\]
    ;













