# devise_security_ng

It adds security features to [devise](http://github.com/plataformatec/devise)

## Features/Modules
- :user_lockable
- :password_reusable

## Installation

Add gem devise_security_ng to your Gemfile. 

```
$ gem 'devise_security_ng', :git => 'git://github.com/take-the-interview/devise_security_ng.git'
```

Install gem

```
$ bundle install
```

## Usage

For devise_security_ng to work some of the built-in devise modules have to be turned off in user model:

- Lockable

Generate migrations for each of the devise_security_ng modules you think of using.
```
$ rails g devise_security_ng:user_lockable <MODEL>
$ rails g devise_security_ng:password_reusable <MODEL>
$ rake db:migrate
```

in User Model add devise_security_ng modules to be used

```
# app/model/user.rb
class User < ActiveRecord::Base
	devise :database_authenticatable, ..... , :user_lockable, :password_reusable
end
```
## Copyright

Copyright (c) 2010 Take The Interview Inc. See LICENSE for details.

Author Alen Komic
