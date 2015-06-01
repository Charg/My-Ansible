#!/usr/bin/env sh
set -eu

# SSH or LOCAL?
if [ -z ${SSH_TTY:+null} ]; then
	# Unbound
	CMD="/usr/bin/gsettings"
else
	# Bound
	CMD="/usr/bin/dbus-launch /usr/bin/gsettings"
fi

# Nautilus Settings
$CMD set org.gnome.nautilus.preferences show-hidden-files true
$CMD set org.gnome.nautilus.preferences always-use-location-entry true
$CMD set org.gnome.nautilus.preferences enable-delete true

# Gnome-Terminal Settings
# We need to use DBUS-LAUNCH when connecting through SSH
# http://askubuntu.com/questions/323776/gsettings-not-working-over-ssh
# This SE ticket helped me find the correct schemas
# http://unix.stackexchange.com/questions/133914/set-gnome-terminal-background-text-color-from-bash-script
$CMD set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-custom-command true
$CMD set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ custom-command zsh

# Gnome Shell and WM Settings
# Disable Dynamic Workspace Creation
# By disabling this setting gnome 3 will create the total number of workspaces I have configured
$CMD set org.gnome.shell.overrides dynamic-workspaces false
$CMD set org.gnome.shell.app-switcher current-workspace-only true
$CMD set org.gnome.desktop.wm.preferences num-workspaces 8

# WM KeyBindings
$CMD set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super>exclam']"
$CMD set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super>at']"
$CMD set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super>numbersign']"
$CMD set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super>dollar']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
$CMD set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
$CMD set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
$CMD set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>r']"
#$CMD org.gnome.desktop.wm.keybindings

# Custom KeyBindings
# Add the custom keybinding locations
$CMD set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

# Set the Custom Bindings
# http://community.linuxmint.com/tutorial/view/1171
## FIREFOX
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>f"
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "/usr/bin/firefox"
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Firefox"

## GNOME Terminal
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>t"
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "/usr/bin/gnome-terminal"
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Terminal"

## Nautilus
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "<Super>e"
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "/usr/bin/nautilus"
$CMD set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "Nautilus"
