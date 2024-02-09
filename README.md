# Welcome 

## Requirements

This app currently works with:

* Ruby 3.0.0
* Rails 7.1.3
* Sqllite3

## Installation

### Clone the repository

```shell
git git@github.com:Sreejith9409/iterable_functionality.git
cd iterable_functionality
```

### Check your Ruby version

```shell
ruby -v
```

The output should start with something like `ruby 3.0.0`

If not, install the right ruby version using [rvm]:

```shell
rvm install 3.0.0
```

### Check your Ruby version

```shell
rails -v
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle
```

### Run Setup Script for development environment

Redis should be up and running before `bin/setup` if not please use the following comment `redis-server --daemonize yes` to execute Redis.

```shell
bin/setup
```

### Set development environment variables

To create credentials for development environment, we can run the following command:

```shell
EDITOR="vim" rails credentials:edit --environment=development
```

The above command does the following:
1. Creates config/credentials/development.key if missing. Don’t commit this file to git version, and update the below key and save it.

```shell
adfd205902a311bf8801ba833a98269e
```

2. Creates config/credentials/development.yml.enc if missing. Commit this file to git version.
3. Decrypts and opens the development credentials file in the default editor.

## Run the logs db migration

```shell
rails db:migrate
```


## Run the server

```shell
rails s
```
-----



### Testing

```shell
rspec spec/requests/event_trackers_spec.rb 
```

# Ruby Analyzer

rubycritic - run on project directory and open `overview.html` by copy pasting link from console to browser
also you can see results in the terminal too.

```
rubycritic
```
or you can just run below command to see analysis output on your terminal
```
rubocop
```

-----
# Best practices

* Use snake case for variable naming
* Use metaprogramming as a last resource
* Abstain from using single line blocks when more than one thing is being done inside of it
* Declare very descriptive method names, no matter if they are long
* Don't name your classes or modules with the type on it, `SearchClass`, `VotableModule`
* Use camel case for naming your classes/modules
* Never build methods with more than 3 arguments
* Choose the syntax `{ key: value }` over `{ :key => value }` for hash
* Choose the one line syntax for `if` and `unless` from the `if/unless ... end` syntax when there is only one condition
* Abstain monkey-patching
* Abstain optional parameters
* Write self-documenting code
* Try to keep your classes as SOLID as possible
* Trust [reek](https://github.com/troessner/reek) & [rubocop](https://github.com/bbatsov/rubocop)
