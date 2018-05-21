# Enable repeat on keydown
defaults write -g ApplePressAndHoldEnabled -bool false

# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show path in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Initial key repeat wait
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Show the ~/Library folder
chflags nohidden ~/Library
