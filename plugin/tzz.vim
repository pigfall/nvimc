function TzzLineIndex()
    return line(".")
endfunction

function TzzColIndex()
    return col(".")
endfunction

function! MoveIfLeftParenthese()
    let l =TzzLineIndex()
    let index = TzzColIndex()
    if TzzGetPreviousChar() == "("
		call cursor(l,index+1)
	else
		exec 'normal! i)'
		call cursor(l,index+1)
	endif
endfunction

function! TzzGetPreviousChar()
	let index = col(".")
	let l = line(".")
	let lastChar =getline(".")[index-2]
    return lastChar
endfunction

function! TzzGetNextChar()
	let index = col(".")
	let l = line(".")
	let next =getline(".")[index-1]
    return next
endfunction

function! TzzcdFile()
	let  curFilename = TzzGetCurFilename()
	let path = TzzBasePath(curFilename)
	if path !=""
		exec "tcd" path
	endif
endfunction

function! TzzGetCurFilename()
	let filename = @%
	return filename
endfunction

function! TzzBasePath(path)
	echo a:path
	let index = strridx(a:path,"/")
	if index != -1
		return a:path[:index]
	endif
	return ""
endfunction

function! Tzz_IsInMiddle(left,right)
  if TzzGetPreviousChar() == a:left && TzzGetNextChar() == a:right
    return 1
  endif
  return 0 
endfunction
	
function! Tzz_IsInBraceMiddle()
  return Tzz_IsInMiddle("{","}")
endfunction


function! Tzz_IsInParentheseMiddle()
  return Tzz_IsInMiddle("(",")")
endfunction

function! TzzEnter()
  echom "enter"
    if Tzz_IsInBraceMiddle()
        call feedkeys("\<cr>\<esc>\<s-o>","n")
        return 1
        ""normal! <s-o>
    endif
    if Tzz_IsInParentheseMiddle()
        call feedkeys("\<cr>\<esc>\<s-o>\<tab>","n")
        return 1
    endif
        call  feedkeys("\<cr>","n")
endfunction

function! TzzFeedLeftParenthese()
  if TzzGetPreviousChar() == "("
    call feedkeys("\<right>","n")
    return 1
  endif
  call feedkeys(")","n")
endfunction
