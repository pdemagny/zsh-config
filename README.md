# zsh-config

## Description

I'm using:

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [antigen](https://github.com/zsh-users/antigen)
- [powerlevel9k](https://github.com/bhilburn/powerlevel9k)
- [nerdfonts](https://github.com/ryanoasis/nerd-fonts)

## Install

- Run the setup script, that will install everything in the current user's home directory:

```
./setup.sh
```

## Tips

- You can use the `zal` alias that will lookup in [git plugin](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git) and [debian plugin](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/debian) for aliases matching the parameter, for example:

```
$ zal rebase
ggu    git pull --rebase origin $(current_branch)
grb    git rebase
grba    git rebase --abort
grbc    git rebase --continue
grbd    git rebase develop
grbi    git rebase -i
grbm    git rebase master
grbs    git rebase --skip
gsr    git svn rebase
gup    git pull --rebase
gupv    git pull --rebase -v
gupa    git pull --rebase --autostash
gupav    git pull --rebase --autostash -v
```