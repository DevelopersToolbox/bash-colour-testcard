<!-- markdownlint-disable -->
<p align="center">
    <a href="https://github.com/DevelopersToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/developerstoolbox/black-and-white-circle-256.png" alt="DevelopersToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/actions/workflows/cicd.yml">
        <img src="https://img.shields.io/github/actions/workflow/status/DevelopersToolbox/bash-colour-testcard/cicd.yml?branch=master&label=build%20status&style=for-the-badge" alt="Github Build Status" />
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/blob/master/LICENSE.md">
        <img src="https://img.shields.io/github/license/DevelopersToolbox/bash-colour-testcard?color=blue&label=License&style=for-the-badge" alt="License">
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard">
        <img src="https://img.shields.io/github/created-at/DevelopersToolbox/bash-colour-testcard?color=blue&label=Created&style=for-the-badge" alt="Created">
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/releases/latest">
        <img src="https://img.shields.io/github/v/release/DevelopersToolbox/bash-colour-testcard?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/releases/latest">
        <img src="https://img.shields.io/github/release-date/DevelopersToolbox/bash-colour-testcard?color=blue&label=Released&style=for-the-badge" alt="Released">
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/releases/latest">
        <img src="https://img.shields.io/github/commits-since/DevelopersToolbox/bash-colour-testcard/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/blob/master/.github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/blob/master/.github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/blob/master/.github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/bash-colour-testcard/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
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

> Note: -c, -n, -s & -t must be used independently and not combined. -m is used in conjunction with the others in order to limit the number of
displayed colours, used on its own it does nothing.


### Test Mode

The -t command parameter will allow you to enter 'test mode'. In this mode the script will ask you to enter values for the foreground and background
colours and it will then display that colour combination with some test text, it will show you a second test output with the text in bold.

You can test as many colour combinations are you like (or until you get bored).

<br />
<p align="right"><a href="https://wolfsoftware.com/"><img src="https://img.shields.io/badge/Created%20by%20Wolf%20on%20behalf%20of%20Wolf%20Software-blue?style=for-the-badge" /></a></p>
