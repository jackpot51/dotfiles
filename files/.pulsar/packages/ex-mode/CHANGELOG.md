## (unpublished)

## 0.18.0

* Add Gdefault support ([#191](https://github.com/lloeki/ex-mode/pull/191))
* Add :sort command ([#190](https://github.com/lloeki/ex-mode/pull/190))

## 0.17.0

* Add support for Atom 1.19 ([#185](https://github.com/lloeki/ex-mode/pull/185))
* Added support for canceling ex-mode with Ctrl-C ([#186](https://github.com/lloeki/ex-mode/pull/186))

## 0.16.0

* Support for Atom 1.18 and 1.19 ([#184](https://github.com/lloeki/ex-mode/pull/184))

## 0.15.0
* `vim-mode-plus` support!
  - Add keybinding (@jmarianer)
  - Support `:substitute` command (@mkiken)
  - Support marks
  - Use `vim-mode-plus` in specs

## 0.14.0
* Support `:tabonly` (@jmarianer)
* Fix `:x` closing Atom instead of the current pane

## 0.13.1
* Limit addresses to the last line
* Fix autocompleting a non existent directory (@mcnicholls)

## 0.13.0
* Added basic support for visual marks (e.g. `:'<,'>s/foo/bar`)
* Added `smartcase` option to `:set`
* Fixed using marks as addresses (e.g. `:'a,.delete`)
* Fixed search not working without a closing delimiter (e.g. `:/foo`)

## 0.12.0
* Added file and command autocomplete (@stuartquin)
* Added `splitbelow` and `splitright` options to `:set`
* Fixed the editor not updating when saving a new file with `:w` or `:saveas`

## 0.11.0

* Stop using non-standard Promise.defer (fixes issue with `:w`) (@AsaAyers)

## 0.9.0

* Added support for yank commands, ex `:1,10y` (@posgarou)
* Added contributor guidelines, including a pull request template
* Added ability to control splitting with `splitright`, and `splitbelow` (@dragonxwang)

### Fixes

* delete commands now add text to clipboard, ex `:1,4d`

## 0.8.0
* Don't allow :s delimiters not allowed by vim (@jacwah)
* Backspace over empty `:` now cancels ex-mode (@shamrin)
* Added option to register alias keys in atom init config (@GertjanReynaert)
* Allow `:substitute` to replace empty with an empty string and replacing the last search item (@jazzpi)
* Added `:wall`, `:quitall` and `:wqall` commands (@caiocutrim)
* Added `:saveas` command (@bakert)

## 0.6.0
* No project/multiple projects paths (uses first one)
* Support for :set
* Fixes

## 0.5.0
* Comply with upcoming Atom API 1.0
* Added `:d`
* Fixes

## 0.4.1 - C-C-C-Combo Edition
* Added ex command parser, including ranges
* Added `:wq`
* Added `:s`
* Alert on unknown or invalid command

## 0.3.0 - Extrovert Edition
* Register new commands from the outside world
* Added `:tabn`, `:tabp`, `:e`, `:enew`, and a few aliases

## 0.2.0 - NotAOneTrickPony Edition
* Added `:quit`, `:tabedit`, `:wa`, `:split`, `:vsplit`
* Commands can take arguments

## 0.1.0 - First Release
* Every feature added
* Every bug fixed
