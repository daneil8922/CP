set hidden
set nowrap
set tabstop=4
set shiftwidth=4
set showtabline
set expandtab
set hlsearch
set encoding=utf-8
set matchpairs+=(:),[:],{:},<:>
set clipboard=unnamedplus
set number

command! -nargs=0 CopileRunShow :w | execute '!g++ -o a ' . expand('%') . '&& ./a < in > ou' | vs ou
command! -nargs=0 CopileRun :w | execute '!g++ -o a ' . expand('%') . '&& ./a < in ' 

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ' ''<left>
inoremap " ""<left>
inoremap jj <Esc>
inoremap <expr> <BS> Rmbs()
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <space> :
nnoremap mm :call Com()<CR>
map um :call CCom()<CR>
nnoremap <F5> :call Run()<CR>
nnoremap qq :q<CR>:q<CR> 
nnoremap cp ggVGy<CR>
nnoremap rm ggVGd<CR>
autocmd BufNewFile *.cpp call Mkarch() | call search('fastio;') | normal! $h
syntax enable
syntax on


function! Rmbs()
		let col = col('.') - 1
		let prev = getline('.')[col - 1]
		let nxto = getline('.')[col]
		if (prev ==# '(' && nxto ==# ')')||(prev ==# '{' && nxto ==# '}')||(prev ==# '[' && nxto ==# ']')||(prev ==# '"' && nxto ==# '"')||(prev ==# "'" && nxto ==# "'")
				return "\<Right>\<BS>\<BS>"
		endif
		return "\<BS>"
endfunction		
function! Enter()
    let col = col('.') - 1
    let prev = getline('.')[col - 1]
    let nxto = getline('.')[col]
    if() 
    endif
    return "<CR>"
endfunction
function! Mkarch()
		let name = expand('%t')
		let fir = strpart(name , 0, 2)
		let p = '~/cp/' . fir 
		let lis = systemlist('ls -1 ' . p)
		let path = '~/cp/' . fir . '/' . name 
		execute 'edit ' . path
		for ele in lis
				if ele == name
						return
				endif
		endfor  
		execute '0read ~/.config/nvim/plantilla.cpp'
endfunction
function! Com()
		execute 'w'
		let path = expand('%:p')
        let er = '~/cp/error.txt'
		silent execute "!g++ -o ~/cp/execute " . path . " > " . er
        if filereadable(er)
            vsplit er
        else
		    vsplit ~/cp/in.txt
        endif
		wincmd h
endfunction
function! CCom()
		execute 'w'
		let path = expand('%:p')
		execute "!g++ -o ~/cp/execute " . path " && ~/cp/execute < ~/in.txt"
		wincmd h
endfunction
function! Run()
		execute 'w'
		execute "silent !~/cp/execute < ~/cp/in.txt > ~/cp/out.txt"
		split ~/cp/out.txt
endfunction    
