defmodule Hexoku.API.Dynos do
	alias Hexoku.Request
	@moduledoc """
	Dynos encapsulate running processes of an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#dyno)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, app) do
		Request.get(client, "/apps/#{app}/dynos")
	end

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, dyno) do
		Request.get(client, "/apps/#{app}/dynos/#{dyno}")
	end

	@spec create(Hexoku.Client.t, binary, binary, Map.t) :: Hexoku.Response.t
	def create(client, app, command, options \\ %{}) do
		body = Dict.put(options, :command, command)
		Request.post(client, "/apps/#{app}/dynos", body)
	end

	@spec restart(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def restart(client, app, dyno) do
		Request.delete(client, "/apps/#{app}/dynos/#{dyno}")
	end

	@spec restart_all(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def restart_all(client, app) do
		Request.delete(client, "/apps/#{app}/dynos")
	end

end
