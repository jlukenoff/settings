# To run on a new machine:

Note: In some environments it may be necessary to run this with `sudo`

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jlukenoff/settings/main/setup.sh)"
```

# To just get the aliases

```sh
# Just in the current shell
. $(curl -fsSL https://raw.githubusercontent.com/jlukenoff/settings/main/configs/aliases)

# Adjust permanently with in zsh environment
curl -fsSL https://raw.githubusercontent.com/jlukenoff/settings/main/configs/aliases >> ~/.zshrc

# Adjust permanently with in bash environment
curl -fsSL https://raw.githubusercontent.com/jlukenoff/settings/main/configs/aliases >> ~/.bash_aliases
```

# To set up a new git ssh key

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jlukenoff/settings/main/scripts/configure_git.sh)"
```
