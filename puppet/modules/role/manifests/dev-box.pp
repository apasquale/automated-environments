# This profile is used for development boxes running 
# on a virtual machine

include profile::chocolatey
include profile::basebox
include profile::dism
include profile::win8-IIS-Feature
include profile::browsers
include profile::git-tools
include profile::text-editors
include profile::sql-install
include profile::vs-install
include profile::vs-extensions
include profile::dev-utilities
include profile::jetbrains
include profile::windows-debug-tools

# include profile::desktop-utilities
# include profile::ruby-packages