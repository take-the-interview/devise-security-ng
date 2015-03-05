# devise_security_ng

It adds security features to [devise](http://github.com/plataformatec/devise)

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

For devise_security_ng to work some of the built-in modules have to be turned off in user model:

- Lockable

Generate migrations
```
$ rails g devise_security_ng User
$ rake db:migrate
```

in User Model add :devise_security_ng

```
# app/model/user.rb
class User < ActiveRecord::Base
	devise :database_authenticatable, ..... , :devise_security_ng
end
```
## Copyright

Copyright (c) 2010 Take The Interview Inc. See LICENSE for details.
