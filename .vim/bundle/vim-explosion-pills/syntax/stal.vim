" Vim syntax file
" Language: Celestia Star Catalogs
" Maintainer: Andrew Crites
" Latest Revision: 2011-08-13

if exists("b:current_syntax")
  finish
endif

syn keyword stalKeyword macro use slot fill

syn region stalComment start='###' end='###'

syn keyword stalType action method class cellspacing cellpadding colspan style href src type value name
syn match stalType '[\.#]'

syn match stalStatementElig "^\s\+"
syn match stalStatement "\(^\|!\)\s*\(strong\|div\|form\|span\|tr\|td\|br\|h1\|h2\|h3\|h4\|h5\|h6\|a\|ol\|li\|ul\|img\|input\|table\|tr\|td\)" contains=stalStatementElig

syn match stalOperator '[<?@\*!\\=%;\^]'

syn match stalContainer '[\[\]]'

hi def link stalComment Comment
hi def link stalKeyword Keyword
hi def link stalChar SpecialChar
hi def link stalType Type
hi def link stalStatement Constant
hi def link stalOperator SpecialChar
hi def link stalContainer Define
hi def link stalString String
hi def link stalNone Structure
hi def link stalNum Number
