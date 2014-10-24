defmodule Hexoku.API.Config do
	alias Hexoku.Request
	@moduledoc """
	Config Vars allow you to manage the configuration information provided to an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#config-vars)
	"""

	@doc """
	Get config-vars for app.

	## Examples
		client |> Hexoku.API.Config.list("myapp")
	"""
	@spec list(Hexoku.Client.t, binary) :: Map.t
	def list(client, app), do: Request.get(client, "/apps/#{app}/config-vars")

	@doc """
	Update config-vars for app.

	You can update existing config-vars by setting them again, and remove by setting it to `nil`.

	## Examples
		client |> Hexoku.API.Config.update("myapp", %{
			"FOO": "BAR",
			"OLD_STUFF": nil
		})
	"""
	@spec update(Hexoku.Client.t, binary, Map.t) :: Map.t
	def update(client, app, body), do: Request.patch(client, "/apps/#{app}/config-vars", body)


end
