function s:Log(...)
	if g:vimChezmoiDebugMode == 1
		echo a:1
	endif
endfunction

function s:GetDotfileFromCommand(cmd)
	return a:cmd[-1]
endfunction

function s:GetParentPid(pid)
	return substitute(system("ps -o ppid= -p " . a:pid), '\n', '\1', '')
endfunction

function s:GetCmdline(pid)
    return split(system("ps -p " . a:pid . " -o args"), "\n")[-1]
endfunction

function g:Chezmoi(...)
	let l:chezmoiBinary = get(g:, "chezmoi_executable", "chezmoi")
        let g:vimChezmoiDebugMode = get(g:, "chezmoi_debug_mode", 0)

	if executable(l:chezmoiBinary) == 0
		echo "vim-chezmoi: The binary \"". l:chezmoiBinary . "\" does not exist. Check your vimrc and/or chezmoi installation."
		return
	endif
	call s:Log("Executable exists")

	let l:pid = getpid()
	call s:Log("Getting parent pid")
        let parentPid = s:GetParentPid(getpid())
	call s:Log("Getting parent pid cmd args")
	let parentPidFileContents = s:GetCmdline(parentPid)
        call s:Log("Parent args: " . parentPidFileContents)
	let l:parentPidFileSplitted = split(l:parentPidFileContents, " ")

	call s:Log(l:parentPidFileSplitted)
	if l:parentPidFileSplitted[0] == l:chezmoiBinary && l:parentPidFileSplitted[1] == "edit"
		let l:dotfile = s:GetDotfileFromCommand(l:parentPidFileSplitted)
		call s:Log("This vim session was launched via chezmoi edit. The dotfile that is being edited is " . l:dotfile)
		let g:chezmoiCommandToExecute = "!" . l:chezmoiBinary . " apply " . l:dotfile
		call s:Log("Cmd to execute on write: " . g:chezmoiCommandToExecute)

		if g:vimChezmoiDebugMode != 1
			let g:chezmoiCommandToExecute = ":silent " . g:chezmoiCommandToExecute
		endif
		au BufWritePost * execute g:chezmoiCommandToExecute

	else
		call s:Log("Chezmoi edit command not found on parent process. It's probably not a chezmoi invoke.")
	endif
endfunction

if exists("g:chezmoi")
    call g:Chezmoi()
endif
