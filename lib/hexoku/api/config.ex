defmodule Hexoku.API.Config do
	alias Hexoku.Request
	@moduledoc """
	Config Vars allow you to manage the configuration information provided to an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#config-vars)
	"""

	@spec list(Hexoku.Client.t, binary) :: Map.t
	def list(client, app), do: Request.get(client, "/apps/#{app}/config-vars")

	@spec update(Hexoku.Client.t, binary, Map.t) :: Map.t
	def update(client, app, body), do: Request.patch(client, "/apps/#{app}/config-vars", body)

end
