# ZSH background plugin

This plugin contains patched version of zsh-add-hook,
it supports functions who will run in background,
by default, every 5 seconds.
For compatibility it was renamed from `add-zsh-hook` to `add-hook`


## Installation

### If you use [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

* Clone this repository into `~/.oh-my-zsh/custom/plugins`

```sh
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zpm-zsh/background
```
* After that, add `background` to your oh-my-zsh plugins array.

### If you use [Zgen](https://github.com/tarjoilija/zgen)

1. Add `zgen load zpm-zsh/background` to your `.zshrc` with your other plugin
2. run `zgen save`

### If you use my [ZPM](https://github.com/zpm-zsh/zpm)

* Add `zpm load zpm-zsh/background` into your `.zshrc`

## Usage example

```bash
add-hook background some_function
```

## Meta

Distributed under the GPL3 license. See ``LICENSE`` for more information.

* [https://github.com/horosgrisa](https://github.com/horosgrisa/)

## Contributing

1. Fork it (<https://github.com/zpm-zsh/background/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
