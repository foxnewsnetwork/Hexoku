Hexoku
======

Basic API support and MIX tasks for Heroku support.

## Warning

This is early work and few API and Mix commands have been finished. I am adding more every day(ish) though.
Some API functions *might* completely change between versions.

## Examples

	client = Hexoku.toolbelt
	client |> Hexoku.API.Apps.list

For complete info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference)

## Mix Support

Hexoku adds some common Heroku commands to your Mix.

The application name is read from the heroku_app key in your `mix.exs` files project.
If that is not defined it falls back to the :app key.

	def project do
		[
			app: :uberweb,
			heroku_app: "uberweb-staging"
			version: "0.0.1",
			elixir: "~> 1.0.0",
			deps: deps
		]
	end

It relies on you having your credentials set up in your `~/.netrc` file.

If you are already using the [Heroku Toolbet](toolbelt.heroku.com) you have likely already set this up using the '`heroku login`' command.
Otherwise you can create `~/.netrc` with the following body:

	machine api.heroku.com
		login user@example.com
		password a1b2c3e4f5
	machine code.heroku.com
		login user@example.com
		password a1b2c3e4f5

### Examples

	bash> mix hexoku.config
		DOWNSTREAM_APP = myapp-production
		REDIS_HOST = somehost.redistogo.com
