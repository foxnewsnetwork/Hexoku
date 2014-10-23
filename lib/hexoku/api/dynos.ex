defmodule Hexoku.API.Dynos do
	alias Hexoku.Request
	@moduledoc """
	Dynos encapsulate running processes of an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#dyno)
	"""

	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/dynos")

	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, dyno), do: Request.get(client, "/apps/#{app}/dynos/#{dyno}")

	@spec create(Hexoku.Client.t, binary, binary, Map.t) :: Map.t
	def create(client, app, command, options \\ %{}) do
		body = Dict.put(options, :command, command)
		Request.post(client, "/apps/#{app}/dynos", body)
	end

	@spec restart(Hexoku.Client.t, binary, binary) :: Map.t
	def restart(client, app, dyno), do: Request.delete(client, "/apps/#{app}/dynos/#{dyno}")

	@spec restart_all(Hexoku.Client.t, binary) :: Map.t
	def restart_all(client, app), do: Request.delete(client, "/apps/#{app}/dynos")

end
