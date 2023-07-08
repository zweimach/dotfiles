; Variables
;----------

(var_exp (ident) @variable)
(var_pat (ident) @variable)
;(val_ldec (vb (app_pat (var_pat (ident) @variable))))

; Functions
;----------

(fun_ldec (fb (clause . (var_pat (ident) @function))))
(app_exp . (var_exp (ident) @function) . (_)+)
(app_exp (access_exp (qident (ident) @function)) . (_)+)

; Types
;----------

(constr (ident) @constructor)
((var_pat (ident) @constructor)
  (#match? @constructor "^[A-Z]"))
((var_exp (ident) @constructor)
  (#match? @constructor "^[A-Z]"))

(con_ty (qident (ident) @type))
(type_ldec (tb (ident) @type))
(datatype_ldec (db (ident) @type))
(exception_ldec (eb (ident) @type))

(access_exp (ident) @namespace)

; Modules
;----------

(structure_dec (strb (ident) @namespace))

; Keywords
;---------

[
  "as"
  "case"
  "datatype"
  "end"
  "exception"
  "fun"
  "handle"
  "in"
  "let"
  "of"
  "raise"
  "sig"
  "signature"
  "struct"
  "structure"
  "type"
  "val"
] @keyword

["if" "then" "else"] @conditional

["fun" "fn"] @keyword.function

; Operators
;---------

[
  (symbolic)

  "="

  "*"

  "=>"

  "andalso"
  "orelse"
] @operator

[ "(" ")" "{" "}" "[" "]" ] @punctuation.bracket

[ "|" "," ":" ";" ] @punctuation.delimiter

; Constants
;----------

(int_constant) @number

(float_constant) @number

(string) @string

(character) @character

((ident) @boolean
  (#match? @boolean "(true|false)"))

(comment) @comment
