Welcome to my [DST](https://www.obsidianportal.com/dynamic_sheet_templates) for [Fate RPG](http://www.faterpg.com/) on [Obsidian Portal](https://www.obsidianportal.com).

Feel free to open an issue for any bugs you find or suggestions you have.


1. [Overview](#overview)
    * [What's in this project](##whats-in-this-project)
    * [Recommended workflow while developing](#suggested-development-workflow)
2. [Setup](#setup)
    * [Requirements](#requirements)
    * [Setting up your development environment](#setting-up-your-development-environment)
    * [While developing](#while-developing)

## Overview

### What's in this project

  - Static web assets (`*.html`, `*.css`, `*.js`)
  - Their source files (`*.html.haml`, `*.scss`, `*.coffee`)
  - A `Guardfile` that knows how to build the source files into the static assets.

### Recommended workflow while developing

  - Edit the _source_ files instead of the static assets
  - Keep an instance of [Guard](https://github.com/guard/guard) running in a separate terminal
  - View your changes by reloading `devkit/index.html` in your web browser
  - Modify any test data in `devkit/example_data.js`

This way, every time you save a source file, Guard will automatically compile the static web assets.


## Setup

### Requirements

You will need [Ruby](https://www.ruby-lang.org/en/), [Bundler](http://bundler.io/), a web browser, and some patience.

### Setting up your development environment

After a checking out this repo, go to the repo's root directory and run
```bash
bundle
```

### While developing

Before modifying any source files, Make sure Guard is running in an extra terminal session:
```bash
bundle exec guard
```
