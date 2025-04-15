" Vim syntax file
" Language: ZModel (ZenStack)

if exists("b:current_syntax")
  finish
endif

" Keywords for declarations
syntax keyword zmodelKeyword model enum type datasource generator plugin
syntax keyword zmodelKeyword extends implements abstract

" Base types
syntax keyword zmodelType String Int Float Boolean DateTime Decimal Bytes Json BigInt

" Modifiers only when prefixed with @ or @@
syntax match zmodelModifier "@@*\(id\|unique\|default\|updatedAt\|ignore\|map\)"

" Function-like attributes (e.g., @default(now()))
syntax match zmodelFunction "@\w\+" nextgroup=zmodelFunctionParens
syntax region zmodelFunctionParens start="(" end=")" contained contains=zmodelString,zmodelNumber,zmodelBoolean,zmodelFunction

" Comments
syntax match zmodelComment "//.*$" contains=@Spell
syntax region zmodelBlockComment start="/\*" end="\*/" contains=@Spell

" Numbers and floats
syntax match zmodelNumber "\<[0-9]\+\>"
syntax match zmodelFloat "\<[0-9]\+\.[0-9]\+\>"

" Strings
syntax region zmodelString start=/"/ skip=/\\"/ end=/"/ contains=@Spell

" Annotations (generic @ or @@ prefix)
syntax match zmodelAnnotation "@@*\w\+"

" Booleans
syntax keyword zmodelBoolean true false

" Highlighting links
highlight def link zmodelKeyword Keyword
highlight def link zmodelType Type
highlight def link zmodelModifier Statement
highlight def link zmodelFunction Function
highlight def link zmodelFunctionParens Delimiter
highlight def link zmodelComment Comment
highlight def link zmodelBlockComment Comment
highlight def link zmodelNumber Number
highlight def link zmodelFloat Float
highlight def link zmodelString String
highlight def link zmodelAnnotation PreProc
highlight def link zmodelBoolean Boolean

let b:current_syntax = "zmodel"
