let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'

nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>a :Rg<Space>
nmap <Leader>r :GrepperRg<Space>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>C :Commands<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>` :History/<CR>
nmap <Leader>M :Maps<CR>
nmap <Leader>s :Filetypes<CR>

nmap <Leader>m :<C-u>FzfPreviewFromResources project_mru git<CR>
nmap <Leader>gs :<C-u>FzfPreviewGitStatus<CR>
let g:fzf_preview_if_binary_command = '[[ "$(file --mime {})" =~ binary ]]'
let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
let g:fzf_preview_filelist_postprocess_command = 'xargs -d "\n" exa --color=always'

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-x': 'vsplit' }
