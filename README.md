# i18n_keys_helper

**i18n_keys_helper** allows you to display translation keys directly on your browser
by moving your mouse on a specifique text, image ..., a tooltip containing the translation key will be showed

i18n_keys_helper is very useful with the [webtranslateit](https://github.com/AtelierConvivialite/webtranslateit) gem, or basically when translations are managed by your clients in a external tool


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n_keys_helper', git: 'git://github.com/MoKuH/i18n_keys_helper'
```

And then execute:

    $ bundle install


Call the helper method in your layout file , just after the body opening tag

```ruby
= render_translate
```

Add the 2 following lines into your ApplicationController

```ruby
include I18nKeysHelper
before_action :set_show_translation_keys
```

## Usage

The i18n_keys_helper is by default only disabled in production, you can easily change it.
The i18n_keys_helper also have a fork on i18n, on production environment, an empty string is returned instead of the missing translation text,
