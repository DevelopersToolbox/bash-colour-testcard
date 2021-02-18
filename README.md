<h1 align="center">
	<a href="https://github.com/WolfSoftware">
		<img src="https://raw.githubusercontent.com/WolfSoftware/branding/master/images/general/banners/64/black-and-white.png" alt="Wolf Software Logo" />
	</a>
	<br>
	Bash Colour Testcard
</h1>

<p align="center">
	<a href="https://travis-ci.com/DevelopersToolbox/bash-colour-testcard">
		<img src="https://img.shields.io/travis/com/DevelopersToolbox/bash-colour-testcard/master?style=for-the-badge&logo=travis" alt="Build Status">
	</a>
	<a href="https://github.com/DevelopersToolbox/bash-colour-testcard/releases/latest">
		<img src="https://img.shields.io/github/v/release/DevelopersToolbox/bash-colour-testcard?color=blue&style=for-the-badge&logo=github&logoColor=white&label=Latest%20Release" alt="Release">
	</a>
	<a href="https://github.com/DevelopersToolbox/bash-colour-testcard/releases/latest">
		<img src="https://img.shields.io/github/commits-since/DevelopersToolbox/bash-colour-testcard/latest.svg?color=blue&style=for-the-badge&logo=github&logoColor=white" alt="Commits since release">
	</a>
	<a href="LICENSE.md">
		<img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" alt="Software License">
	</a>
	<br>
	<a href=".github/CODE_OF_CONDUCT.md">
		<img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
	<a href=".github/CONTRIBUTING.md">
		<img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
	<a href=".github/SECURITY.md">
		<img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
	<a href=".github/SUPPORT.md">
		<img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
</p>

## Overview

This is a script to display a matrix of colours based on the number of colours that your terminal is able to support.

It will make best efforts to size the output to the size of your terminal making it display nicely in most terminals.

It has the following command line options

```
Usage: bash-colour-testcard.sh [ -h ] [ -cnst ] [ -m number ]

  -h    : Print this screen
  -c    : complete mode (foreground & background [256 x 256])
  -m    : set the maximum number of colours to display (between 0-256)
  -n    : display just the number of supported colours
  -s    : simple mode (colour codes only [256])
  -t    : test mode (will prompt you for colour codes and display the results)
```

> Note: -c, -n, -s & -t must be used independently and not combined. -m is used in conjunction with the others in order to limit the number of displayed colours, used on its own it does nothing.


### Test Mode

The -t command parameter will allow you to enter 'test mode'. In this mode the script will ask you to enter values for the foreground and background colours and it will then display that colour combination with some test text, it will show you a second test output with the text in bold.

You can test as many colour combinations are you like (or until you get bored).

## Contributors

<p>
	<a href="https://github.com/TGWolf">
		<img src="https://img.shields.io/badge/Wolf-black?style=for-the-badge" />
	</a>
</p>

## Show Support

<p>
	<a href="https://ko-fi.com/wolfsoftware">
		<img src="https://img.shields.io/badge/Ko%20Fi-blue?style=for-the-badge&logo=ko-fi&logoColor=white" />
	</a>
</p>
