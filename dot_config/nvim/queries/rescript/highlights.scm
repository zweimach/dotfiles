(comment) @comment

; Identifiers
;------------

(array_pattern (value_identifier) @variable)
(as_aliasing (value_identifier) @variable)
(parenthesized_pattern (value_identifier) @variable)

(arguments
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(binary_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(expression_statement
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(field
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(function
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(if_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(jsx_attribute
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(labeled_argument
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(let_binding
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(member_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(parenthesized_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(pipe_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(record_field
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(record_pattern
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(spread_element
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(switch_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(ternary_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(tuple
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(tuple_item_pattern
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])
(unary_expression
  [(value_identifier) @variable
   (value_identifier_path (value_identifier) @variable)])

; Escaped identifiers like \"+."
((value_identifier) @constant.macro
 (#match? @constant.macro "^\\.*$"))

[
  (type_identifier)
  (unit_type)
  (list)
  (list_pattern)
] @type

[
  (variant_identifier)
  (polyvar_identifier)
] @constructor

(record_type_field (property_identifier) @property)
(record_field (property_identifier) @property)
(object (field (property_identifier) @property))
(object_type (field (property_identifier) @property))
(member_expression (property_identifier) @property)
(module_identifier) @namespace

; Parameters
;----------------

(formal_parameters (value_identifier) @parameter)
(list_pattern (value_identifier) @parameter)
(spread_pattern (value_identifier) @parameter)
(switch_match (value_identifier) @parameter)

; String literals
;----------------

[
  (string)
  (template_string)
] @string

(template_substitution
  "${" @punctuation.bracket
  "}" @punctuation.bracket) @embedded

(character) @string.special
(escape_sequence) @string.escape

; Other literals
;---------------

[
  (true)
  (false)
] @boolean

(number) @number
(polyvar) @constant
(polyvar_string) @constant

; Functions
;----------

(let_binding
  (value_identifier) @function
  (function))

; parameter(s) in parens
[
 (parameter (value_identifier))
 (labeled_parameter (value_identifier))
] @parameter

; single parameter with no parens
(function parameter: (value_identifier) @parameter)

; first-level descructuring (required for nvim-tree-sitter as it only matches direct
; children and the above patterns do not match destructuring patterns in NeoVim)
(parameter (tuple_pattern (tuple_item_pattern (value_identifier) @parameter)))
(parameter (array_pattern (value_identifier) @parameter))
(parameter (record_pattern (value_identifier) @parameter))

(call_expression
  function: (value_identifier) @function.call)
(call_expression
  function: (value_identifier_path (value_identifier) @function.call))
(pipe_expression
  (value_identifier_path (value_identifier) @function.call))
(pipe_expression
  (_) .
  (value_identifier) @function.call)

; Meta
;-----

(decorator_identifier) @annotation

(extension_identifier) @keyword
("%") @keyword

; Misc
;-----

(subscript_expression index: (string) @property)
(polyvar_type_pattern "#" @constant)

[
  ("include")
  ("open")
] @include

[
  "as"
  "export"
  "external"
  "let"
  "module"
  "mutable"
  "private"
  "rec"
  "type"
  "and"
  "assert"
  "await"
  "with"
  "lazy"
  "constraint"
] @keyword

((function "async" @keyword))

(module_unpack "unpack" @keyword)

[
  "if"
  "else"
  "switch"
  "when"
] @conditional

[
  "exception"
  "try"
  "catch"
] @exception

(call_expression
  function: (value_identifier) @exception
  (#eq? @exception "raise"))

[
  "for"
  "in"
  "to"
  "downto"
  "while"
] @repeat

[
  "."
  ","
  "|"
  ":"
  ";"
] @punctuation.delimiter

[
  "++"
  "+"
  "+."
  "-"
  "-."
  "*"
  "**"
  "*."
  "/."
  "<="
  "=="
  "==="
  "!"
  "!="
  "!=="
  ">="
  "&&"
  "||"
  "="
  ":="
  "->"
  "|>"
  ":>"
  "+="
  (uncurry)
] @operator

; Explicitly enclose these operators with binary_expression
; to avoid confusion with JSX tag delimiters
(binary_expression ["<" ">" "/"] @operator)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(polyvar_type
  [
   "["
   "[>"
   "[<"
   "]"
  ] @punctuation.bracket)

(type_arguments ["<" ">"] @punctuation.bracket)
(type_parameters ["<" ">"] @punctuation.bracket)

[
  "~"
  "?"
  "=>"
  ".."
  "..."
] @punctuation.special

(ternary_expression ["?" ":"] @operator)

; JSX
;----------
(jsx_identifier) @tag
(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @tag.delimiter))
(jsx_element
  close_tag: (jsx_closing_element ["<" "/" ">"] @tag.delimiter))
(jsx_self_closing_element ["/" ">" "<"] @tag.delimiter)
(jsx_fragment [">" "<" "/"] @tag.delimiter)
(jsx_attribute (property_identifier) @tag.attribute)

; Error
;----------

(ERROR) @error
