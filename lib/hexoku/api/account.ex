defmodule Hexoku.API.Account do
	alias Hexoku.Request
	@moduledoc """
	An account represents an individual signed up to use the Heroku platform.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#account)
	"""

	@spec info(Hexoku.Client.t) :: Map.t
	def info(client), do: Request.get(client, "/account")

	@spec update(Hexoku.Client.t, Map.t) :: Map.t
	def update(client, body), do: Request.get(client, "/account", body)

end
