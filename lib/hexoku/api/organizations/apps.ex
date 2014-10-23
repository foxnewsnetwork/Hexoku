defmodule Hexoku.API.Organizations.Apps do
	alias Hexoku.Request
	@moduledoc """
	An organization app encapsulates the organization specific functionality of Heroku apps.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#organization-app)
	"""

	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/organizations/apps")

	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, org), do: Request.get(client, "/organizations/#{org}/apps")

end
