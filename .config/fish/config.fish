if status is-interactive
    set fish_greeting
    set -x VISUAL nvim
    set -x EDITOR $VISUAL
    set PATH ~/.local/bin $PATH

    set -x DOTNET_CLI_TELEMETRY_OUTPUT 1

    # Add go binaries to path
    fish_add_path ~/go/bin

    switch (uname)
        case Darwin
            # add brew
            fish_add_path /opt/homebrew/bin
        case Linux
            alias keybus="setxkbmap us"
            alias keybca="setxkbmap ca"
            alias z="zathura"

            # set -x JAVA_HOME /usr/lib/jvm/default
            set -x JDK_HOME /usr/lib/jvm/java-17-openjdk

            # Matlab opens up a blank grey window
            # set -x _JAVA_AWT_WM_NONREPARENTING 1

            # Local install of jupyter lab extensions
            set -x JUPYTERLAB_DIR ~/.local/share/jupyter/lab

            # Libtorch binaries
            set -x LIBTORCH /usr/lib/python3.10/site-packages/torch
            set -x LD_LIBRARY_PATH {$LIBTORCH}/lib:$LD_LIBRARY_PATH

            # Make java language server work (jdtls)
            export JDTLS_HOME=/usr/share/java/jdtls
            export GRADLE_HOME=$HOME/gradle
            export WORKSPACE=$HOME/workspace
            export CLASSPATH=".:/usr/share/java/antlr-complete.jar:$CLASSPATH"

            # Podmaneroo
            export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
            export DOCKER_BUILDKIT=0

            # Install npm packages for user
            export npm_config_prefix="$HOME/.local"

            set -x PYENV_ROOT $HOME/.pyenv
            fish_add_path $PYENV_ROOT/bin

            # Android emulator avds path
            # set -x ANDROID_SDK_HOME ~/.android/avd
            # set -x ANDROID_SDK_ROOT /opt/android-sdk
            # set -x ANDROID_HOME /opt/android-sdk/platform-tools

            pyenv init - | source
    end

    alias gitsane="git config pull.rebase true && git config rebase.autostash true"
    alias n="nvim"

    alias l="eza --long --all --group --header --icons"
    alias la="eza --long --all --group --header --binary --links --inode --blocks --icons"
    alias lt="eza --long --all --group --header --icons --tree --level"
    alias gg="lazygit"
    alias gd="lazydocker"

    source ~/.config/fish/git_id.fish

    starship init fish | source
end
