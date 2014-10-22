defmodule Hexoku.API.Slugs do
	alias Hexoku.Request
	@moduledoc """
	A slug is a snapshot of your application code that is ready to run on the platform.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#slug)
	"""

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, slug) do
		Request.get(client, "/apps/#{app}/slugs/#{slug}")
	end

	@spec create(Hexoku.Client.t, binary, Map.t) :: Hexoku.Response.t
	def create(client, app, body) do
		Request.post(client, "/apps/#{app}/slugs", body)
	end


end
