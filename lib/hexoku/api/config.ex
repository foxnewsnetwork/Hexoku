defmodule Hexoku.API.Config do
	alias Hexoku.Request
	@moduledoc """
	Config Vars allow you to manage the configuration information provided to an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#config-vars)
	"""

	@spec list(any, binary) :: any
	def list(client, app) do
		Request.get(client, "/apps/#{app}/config-vars")
	end

	@spec update(any, binary, map) :: any
	def update(client, app, body) do
		Request.path(client, "/apps/#{app}/config-vars", body)
	end

end
