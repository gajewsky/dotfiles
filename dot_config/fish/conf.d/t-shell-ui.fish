# fzf.fish configuration
set -gx fzf_diff_highlighter delta --paging=never --width=20
set -gx fzf_preview_file_cmd bat --style=numbers --color=always
set -gx fzf_preview_dir_cmd eza --all --color=always

if status is-interactive
    # Move fzf variables search off Ctrl+V so Ghostty can use it for paste.
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --variables=ctrl-alt-v
    end

    # PC-style word navigation: Ctrl+F/B move by word instead of char.
    bind ctrl-f forward-word
    bind ctrl-b backward-word
end

# fzf Gruvbox Dark colors
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#3c3836,bg:#282828,spinner:#d3869b,hl:#fabd2f \
--color=fg:#ebdbb2,header:#928374,info:#83a598,pointer:#fb4934 \
--color=marker:#fe8019,fg+:#ebdbb2,prompt:#b8bb26,hl+:#fe8019 \
--color=selected-bg:#504945 \
--border=rounded --separator='─' --scrollbar='│'"

# eza Gruvbox Dark colors
set -gx EZA_COLORS "\
di=38;2;131;165;152:\
ln=38;2;142;192;124:\
ex=38;2;184;187;38:\
fi=38;2;235;219;178:\
bd=38;2;250;189;47:\
cd=38;2;250;189;47:\
so=38;2;211;134;155:\
pi=38;2;254;128;25:\
or=38;2;251;73;52:\
mi=38;2;251;73;52:\
ur=38;2;250;189;47:uw=38;2;251;73;52:ux=38;2;184;187;38:\
gr=38;2;250;189;47:gw=38;2;251;73;52:gx=38;2;184;187;38:\
tr=38;2;250;189;47:tw=38;2;251;73;52:tx=38;2;184;187;38:\
su=38;2;251;73;52:sf=38;2;251;73;52:\
da=38;2;146;131;116:\
sn=38;2;142;192;124:sb=38;2;142;192;124:\
uu=38;2;184;187;38:un=38;2;251;73;52:\
gu=38;2;131;165;152:gn=38;2;251;73;52:\
ga=38;2;184;187;38:gm=38;2;254;128;25:gd=38;2;251;73;52:\
gv=38;2;142;192;124:gt=38;2;131;165;152:\
xx=38;2;102;92;84"
