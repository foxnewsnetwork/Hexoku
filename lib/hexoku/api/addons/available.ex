defmodule Hexoku.API.Addons.Available do
	alias Hexoku.Request
	@moduledoc """
	Add-on services represent add-ons that may be provisioned for apps.
	Plans represent different configurations of add-ons that may be added to apps.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#plan)
	"""

	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/addon-services")

	@spec info(Hexoku.Client.t, binary) :: Map.t
	def info(client, service), do: Request.get(client, "/addon-services/#{service}")

	@spec plans(Hexoku.Client.t, binary) :: [Map.t]
	def plans(client, service), do: Request.get(client, "/addon-services/#{service}/plans")

	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, service, plan), do: Request.get(client, "/addon-services/#{service}/plans/#{plan}")

end
