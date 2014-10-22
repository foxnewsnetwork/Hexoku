defmodule Hexoku.API.Regions do
	alias Hexoku.Request
	@moduledoc """
	A region represents a geographic location in which your application may run.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#region)
	"""

	@spec list(Hexoku.Client.t) :: Hexoku.Response.t
	def list(client) do
		Request.get(client, "/regions")
	end

	@spec info(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def info(client, region) do
		Request.get(client, "/regions/#{region}")
	end

end
