defmodule Hexoku do
	@moduledoc """
	Basic API support and MIX tasks for Heroku support.

	## Warning

	This is early work and few API and Mix commands have been finished. I am adding more every week(ish) though.
	Some API functions *might* completely change between versions.

	## Examples

		client = Hexoku.toolbelt
		client |> Hexoku.API.Apps.list

	For complete info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference)

	## Mix Support

	Hexoku adds some common Heroku commands to your Mix. It relies on [Heroku Toolbet](toolbelt.heroku.com) being
	installed and logged in.

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

	### Examples

		bash> mix hexoku.config
			DOWNSTREAM_APP = myapp-production
			REDIS_HOST = somehost.redistogo.com

	"""

	defmodule Client do
		defstruct auth: nil
		@type auth :: Hexoku.Client.Auth.OAuth2.t | Hexoku.Client.Auth.Basic.t
		@type t :: %__MODULE__{auth: auth}
		@moduledoc false

		defmodule Auth do
			@moduledoc false
			defprotocol Authenticate do
				def auth_header(auth)
			end

			defmodule Basic do
				@moduledoc false
				defstruct username: nil, password: nil
				@type t :: %__MODULE__{username: binary, password: binary}
			end
			defimpl Authenticate, for: Basic do
				def auth_header(auth), do: {"Authorization", "Basic " <> Base.encode64(auth.username <> ":" <> auth.password)}
			end

			defmodule OAuth2 do
				@moduledoc false
				defstruct token: nil
				@type t :: %__MODULE__{token: binary}
			end
			defimpl Authenticate, for: OAuth2 do
				def auth_header(auth), do: {"Authorization", Base.encode64(":" <> auth.token)}
			end

		end

	end

	defmodule Response do
		defstruct status: nil, body: nil
		@type t :: %__MODULE__{status: integer, body: any}
	end

	def start() do
		:application.ensure_all_started(:hexoku)
	end

	@doc """
	Create a Hexoku client using username and password.

	## Examples:

		client = Hexoku.basic("HEROKU_USER", "HEROKU_PASS")

	"""
	@spec basic(binary, binary) :: Hexoku.Client.t
	def basic(username, password) do
		Hexoku.Request.start
		%Hexoku.Client{
			auth: %Hexoku.Client.Auth.Basic{username: username, password: password}
		}
	end

	@doc """
	Create a Hexoku client using OAuth2 token.

	## Examples:

		client = Hexoku.oauth2("HEROKU_KEY")

	"""
	@spec oauth2(binary) :: Hexoku.Client.t
	def oauth2(token) do
		Hexoku.Request.start
		%Hexoku.Client{
			auth: %Hexoku.Client.Auth.OAuth2{token: token}
		}
	end

	@doc """
	Create a Hexoku client using token from the [Heroku Toobelt](https://toolbelt.heroku.com/) if installed.
	Optionally define a custom heroku command if you are using new [Go client](https://github.com/heroku/hk).

	## Examples:

		client = Hexoku.toolbelt
		client = Hexoku.toolbelt("hk")
	"""
	@spec toolbelt(binary, binary) :: Hexoku.Client.t
	def toolbelt(command \\ "heroku", argument \\ "auth:token") do
		Hexoku.Request.start
		{token, 0} = System.cmd command, [argument]
		%Hexoku.Client{
			auth: %Hexoku.Client.Auth.OAuth2{token: String.strip(token)}
		}
	end


end
