" Vim syntax file
" Language: ZenStack (ZModel)
" Maintainer: generated from zenstackhq/zenstack langium grammar
" Filenames: *.zmodel

if exists("b:current_syntax")
  finish
endif

syn case match

" Comments
syn keyword zmodelTodo        contained TODO FIXME XXX NOTE HACK
syn match   zmodelDocComment  "///.*$"  contains=zmodelTodo,@Spell
syn match   zmodelLineComment "//\(/\)\@!.*$" contains=zmodelTodo,@Spell
syn region  zmodelBlockComment start="/\*" end="\*/" contains=zmodelTodo,@Spell

" Declaration keywords
syn keyword zmodelDeclaration model enum type view datasource generator plugin attribute function procedure mutation
syn keyword zmodelStorageClass abstract
syn keyword zmodelKeyword      import extends with in

" Boolean / null / this literals
syn keyword zmodelBoolean true false
syn keyword zmodelNull    null Null Undefined
syn keyword zmodelSelf    this

" Builtin scalar and expression types
syn keyword zmodelType String Boolean Int BigInt Float Decimal DateTime Json Bytes
syn keyword zmodelType Any Object Void Unsupported
syn keyword zmodelType ContextType FieldReference TransitiveFieldReference

" Attributes: @@@internal, @@model, @field
syn match zmodelInternalAttr "@@@\([_a-zA-Z][[:alnum:]_]*\.\)*[_a-zA-Z][[:alnum:]_]*"
syn match zmodelModelAttr    "@@\([_a-zA-Z][[:alnum:]_]*\.\)*[_a-zA-Z][[:alnum:]_]*"
syn match zmodelFieldAttr    "@\([_a-zA-Z][[:alnum:]_]*\.\)*[_a-zA-Z][[:alnum:]_]*"

" Numbers
syn match zmodelNumber "\<[+-]\=\d\+\(\.\d\+\)\=\>"

" Strings (double- and single-quoted, with escapes)
syn region zmodelString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=zmodelEscape,@Spell
syn region zmodelString start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=zmodelEscape,@Spell
syn match  zmodelEscape +\\.+ contained

" Operators and punctuation
syn match zmodelOperator    "!=\|==\|<=\|>=\|&&\|||\|[!<>=?^]"
syn match zmodelDelimiter   "[(){}\[\]]"
syn match zmodelPunctuation "[,;:.]"

" Optional / array type markers on field types (visual hint after an identifier)
syn match zmodelOptional "?"
syn match zmodelArray    "\[\]"

" Declaration name highlighting: name after `model`, `enum`, `type`, `view`, etc.
syn match zmodelDeclName "\(\<\(model\|enum\|type\|view\|datasource\|generator\|plugin\|attribute\|function\|procedure\|mutation\)\>\s\+\)\@<=[_a-zA-Z][[:alnum:]_]*"

" Highlight links
hi def link zmodelTodo          Todo
hi def link zmodelDocComment    SpecialComment
hi def link zmodelLineComment   Comment
hi def link zmodelBlockComment  Comment

hi def link zmodelDeclaration   Keyword
hi def link zmodelStorageClass  StorageClass
hi def link zmodelKeyword       Keyword

hi def link zmodelBoolean       Boolean
hi def link zmodelNull          Constant
hi def link zmodelSelf          Identifier

hi def link zmodelType          Type

hi def link zmodelInternalAttr  PreProc
hi def link zmodelModelAttr     PreProc
hi def link zmodelFieldAttr     Macro

hi def link zmodelNumber        Number
hi def link zmodelString        String
hi def link zmodelEscape        SpecialChar

hi def link zmodelOperator      Operator
hi def link zmodelDelimiter     Delimiter
hi def link zmodelPunctuation   Delimiter
hi def link zmodelOptional      Special
hi def link zmodelArray         Special

hi def link zmodelDeclName      Structure

let b:current_syntax = "zmodel"
