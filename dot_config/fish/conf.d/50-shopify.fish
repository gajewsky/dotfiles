# Shopify tools (wish, worldjump, tec)
if test (uname) = "Darwin"
    set -gx __wishConfig "fish:$HOME/.config/wish.fish.toml"

    if command -q starship
        # Init starship before tec so wish wraps starship's prompt, not fish default.
        starship init fish | source
    end

    set -l tec_init $HOME/.local/state/tec/profiles/base/current/global/init
    if test -x $tec_init
        $tec_init fish | source
    end
end
