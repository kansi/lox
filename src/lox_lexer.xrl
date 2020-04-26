Definitions.

STRING         = \"(\\.|[^\\\"])*\"
INTEGER        = [-+]?[0-9]+
FLOAT          = [-+]?[0-9]+\.[0-9]+
INVLAID_FLOAT  = [-+]?(\.[0-9]+|[0-9]+\.)
WHITESPACE     = [\t\r\s\n]
IDENTIFIER     = [a-z]+[a-zA-Z0-9_]*
C_LT           = <
C_GT           = >
C_LEQ          = <=
C_GEQ          = >=
C_NEQ          = !=

Rules.

%% Single-character tokens
\(          : {token, {left_paran, TokenLine}}.
\)          : {token, {right_paran, TokenLine}}.
\{          : {token, {left_brace, TokenLine}}.
\}          : {token, {right_brace, TokenLine}}.
\,          : {token, {comma, TokenLine}}.
\.          : {token, {dot, TokenLine}}.
\-          : {token, {minus, TokenLine}}.
\+          : {token, {plus, TokenLine}}.
\;          : {token, {semicolon, TokenLine}}.
\/          : {token, {slash, TokenLine}}.
\*          : {token, {star, TokenLine}}.
!           : {token, {bang, TokenLine}}.
=           : {token, {equal, TokenLine}}.

{C_LEQ}         : {token, {comparator_leq, TokenLine}}.
{C_GEQ}         : {token, {comparator_geq, TokenLine}}.
{C_NEQ}         : {token, {comparator_neq, TokenLine}}.
{C_LT}          : {token, {comparator_lt, TokenLine}}.
{C_GT}          : {token, {comparator_gt, TokenLine}}.

{WHITESPACE}+ : skip_token.
{IDENTIFIER}  : {token, {identifier, TokenLine, list_to_binary(TokenChars)}}.

{STRING}         : {token, {integer, TokenLine, list_to_integer(strip(TokenChars, TokenLen))}}.
{INTEGER}        : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}          : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{INVLAID_FLOAT}  : {error, {invalid_float, TokenChars}}.

Erlang code.

strip(TokenChars,TokenLen) ->
    lists:sublist(TokenChars, 2, TokenLen - 2).
