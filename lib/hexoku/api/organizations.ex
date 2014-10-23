defmodule Hexoku.API.Organizations do
	alias Hexoku.Request
	@moduledoc """
	Organizations allow you to manage access to a shared group of applications across your development team.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#organization)
	"""

	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/organizations")

	@spec update(Hexoku.Client.t, binary, Map.t) :: Map.t
	def update(client, org, body), do: Request.patch(client, "/organizations/#{org}", body)


end
