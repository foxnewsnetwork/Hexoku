defmodule Hexoku.API.Organizations do
	alias Hexoku.Request
	@moduledoc """
	Organizations allow you to manage access to a shared group of applications across your development team.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#organization)
	"""

	@spec list(Hexoku.Client.t) :: Hexoku.Response.t
	def list(client) do
		Request.get(client, "/organizations")
	end

	@spec update(Hexoku.Client.t, binary, map) :: Hexoku.Response.t
	def update(client, org, body) do
		Request.patch(client, "/organizations/#{org}", body)
	end


end
