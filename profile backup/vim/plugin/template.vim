" File: template.vim
" Author: Wonder <wonderbeyond@gmail.com>
" Description:
"   Generates template for new files.
"   这里主要根据文件名加载模板, 而不是根据 vim 识别到的文件类型.
"   .c 和 .h 文件可能会被识别为相同类型, 显然它们需要不同的模板.
" Rules:
" *先看整个文件名(不含路径), 再看扩展名.
"   例如 main.cc 文件中会定义 main 函数, 其他 .cc 文件则未必然.
" *先看是否有普通的静态模板, 再看是否有动态模板.

"if exists("g:enable_template") && g:enable_template == 1 && exists("g:template_dir")
"    augroup Template_Generator
"        autocmd! Template_Generator
"        autocmd BufNewFile * call Read_template()
"    augroup END
"else
"    finish
"endif
if exists("g:template_load") && g:template_load == 1
	augroup Template_Loader
		autocmd!
		au BufNewFile * call LoadTemplate()
	augroup END
else
	finish
endif
let g:T_DATE_FORMAT = strftime("20%y-%m-%d %H:%M:%S")
function! LoadTemplate()
	let s:template_file = ""
	let g:template_prefix = exists("g:template_prefix") ? g:template_prefix : 'tpl'
	let s:ext = expand('%:e')
	if s:ext == ""
		let s:ext = expand('%:t')
	endif
	let s:template_file_name = g:template_prefix . '.' . s:ext
	if exists("g:template_path")
		let s:template_file = g:template_path.'/'.s:template_file_name
	else
		let s:template_dir_name = exists("g:template_dir_name") ? g:template_dir_name : 'templates'
		let s:rtp = &runtimepath
		let s:dirs = split(s:rtp, ',')
		if empty(s:dirs)
			return
		endif
		for dir in s:dirs
			let s:template_file = dir.'/'.s:template_dir_name.'/'.s:template_file_name
			if filereadable(s:template_file)
				break
			endif
		endfor
		"unlet s:rtp, s:dirs, s:template_dir_name
	endif
	if s:template_file=="" || !filereadable(s:template_file)
		echo "Missing template file. (".s:template_file.")"
		return
	endif
	call LoadTemplateFile(s:template_file)
endfunction

function! LoadTemplateFile(filename)
	let choice = 1
	if exists("g:template_confirm") && g:template_confirm==1
		let choice = confirm("Do you want to load template for this new file?", "&Yes\n&No")
	endif
	if choice==0
		return
	endif
	sil! execute "0r " . a:filename
	call TemplateReplTags()
endfunction

function! TemplateReplTags()
	if g:template_tags_replacing != 1
		return
	endif
	let sl = exists("g:template_replace_start_line") ? g:template_replace_start_line : 1
	let el = exists("g:template_replace_end_line") ? g:template_replace_end_line : "$"
	if exists("g:T_AUTHOR")
		sil! execute sl.','.el."s/<T_AUTHOR>/".g:T_AUTHOR."/g"
	endif
	if exists("g:T_AUTHOR_EMAIL")
		sil! execute sl.','.el."s/<T_AUTHOR_EMAIL>/".g:T_AUTHOR_EMAIL."/g"
	endif
	if exists("g:T_AUTHOR_WEBSITE")
		sil! execute sl.','.el."s=<T_AUTHOR_WEBSITE>=".g:T_AUTHOR_WEBSITE."=g"
	endif
	if exists("g:T_LICENSE")
		sil! execute sl.','.el."s/<T_LICENSE>/".g:T_LICENSE."/g"
	endif
	if exists("g:T_DATE_FORMAT") 
		sil! execute sl.','.el."s/<T_CREATE_DATE>/".strftime(g:T_DATE_FORMAT)."/g"
	endif
	if exists("g:T_FILENAME_USE_FULL_PATH") && g:T_FILENAME_USE_FULL_PATH==1
		let s:fn = expand("%:p")
	else
		let s:fn = expand("%:t")
	endif
	sil! execute sl.','.el."s/<T_FILENAME>/".s:fn."/g"
	unlet s:fn
	let s:curpos = search("<T_CURSOR>", 'W')
	if !empty(s:curpos)
		call cursor(s:curpos)
		sil! execute "normal df>"
		sil! execute "startinsert"
	endif
endfunction
"let s:common_tpl_dir  = g:template_dir . "/common"
"let s:dynamic_tpl_dir = g:template_dir . "/dynamic"
"
"function! Read_template()
"    let filename = expand("%:t")
"    let extname  = expand("%:e")
"
"    " 先检查是否存在[普通的][全名]匹配模板(例如 main.cc).
"    let common_tpl_file = expand(s:common_tpl_dir . "/full/" . filename)
"    if filereadable(common_tpl_file)
"        call Read_template_file(common_tpl_file)
"        return
"    endif
"
"    " 再检查是否存在[动态的][全名]匹配模板.
"    let dynamic_template_generator = expand(s:dynamic_tpl_dir . "/full/" .filename)
"    if executable(dynamic_template_generator)
"        call Read_dynamic_template(dynamic_template_generator, filename)
"        return
"    endif
"
"    " 再检查是否存在[普通的][后缀]匹配模板.
"    let common_tpl_file = expand(s:common_tpl_dir . "/ext/" . extname)
"    if filereadable(common_tpl_file)
"        call Read_template_file(common_tpl_file)
"        return
"    endif
"
"    " 最后检查是否存在[动态的][后缀]匹配模板.
"    let dynamic_template_generator = expand(s:dynamic_tpl_dir . "/ext/" . extname)
"    if executable(dynamic_template_generator)
"        call Read_dynamic_template(dynamic_template_generator, filename)
"        return
"    endif
"endfunction
"
"function! Read_template_file(filename)
"    silent execute "0r " . a:filename
"endfunction
"
"" 读取模板生成器动态生成的模板.
"" generator参数指定生成器程序的路径.
"" 同时还把文件名传递给生成器.
"function! Read_dynamic_template(generator, filename)
"    silent execute "0r !" . a:generator . " " . a:filename
"endfunction