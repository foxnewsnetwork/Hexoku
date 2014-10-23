defmodule Hexoku.API.Sources do
	alias Hexoku.Request
	@moduledoc """
	A source is a location for uploading and downloading an application’s source code.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#source)
	"""

	@spec create(Hexoku.Client.t, binary, Map.t) :: Map.t
	def create(client, app, body \\ %{}), do: Request.create(client, "/apps/#{app}/source", body)


end
