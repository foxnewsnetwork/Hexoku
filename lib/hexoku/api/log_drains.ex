defmodule Hexoku.API.LogDrains do
	alias Hexoku.Request
	@moduledoc """
	Log drains provide a way to forward your Heroku logs to an external syslog server for long-term archiving.
	This external service must be configured to receive syslog packets from Heroku, whereupon its URL can be added to an
	app using this API.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#log-drain)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, app) do
		Request.get(client, "/apps/#{app}/log-drains")
	end

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, drain) do
		Request.get(client, "/apps/#{app}/log-drains/#{drain}")
	end

	@spec create(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def create(client, app, url) do
		Request.post(client, "/apps/#{app}/log-drains", %{url: url})
	end

	@spec delete(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def delete(client, app, drain) do
		Request.delete(client, "/apps/#{app}/log-drains/#{drain}")
	end

end
