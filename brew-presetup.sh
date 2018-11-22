# rather than giving sudo to brew install script, I am setting up things here (yes, I am being security paranoid)
/usr/bin/sudo /bin/mkdir -p /usr/local/Homebrew /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/sbin /usr/local/share /usr/local/var /usr/local/opt /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew /usr/local/var/homebrew/linked /usr/local/Cellar /usr/local/Caskroom /usr/local/Frameworks
/usr/bin/sudo /bin/chmod g+rwx /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/sbin /usr/local/share /usr/local/var /usr/local/opt /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew /usr/local/var/homebrew/linked /usr/local/Cellar /usr/local/Caskroom /usr/local/Frameworks
/usr/bin/sudo /bin/chmod 755 /usr/local/share/zsh /usr/local/share/zsh/site-functions
/usr/bin/sudo /usr/sbin/chown $USER /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/sbin /usr/local/share /usr/local/var /usr/local/opt /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew /usr/local/var/homebrew/linked /usr/local/Cellar /usr/local/Caskroom /usr/local/Frameworks /usr/local/Homebrew
/usr/bin/sudo /usr/bin/chgrp admin /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/sbin /usr/local/share /usr/local/var /usr/local/opt /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew /usr/local/var/homebrew/linked /usr/local/Cellar /usr/local/Caskroom /usr/local/Frameworks
/usr/bin/sudo /bin/mkdir -p /Library/Caches/Homebrew
/usr/bin/sudo /bin/chmod g+rwx /Library/Caches/Homebrew
/usr/bin/sudo /usr/sbin/chown $USER /Library/Caches/Homebrew
/usr/bin/sudo /usr/sbin/chown $USER /usr/local/Homebrew
/bin/mkdir -p /Users/$USER/Library/Caches/Homebrew
