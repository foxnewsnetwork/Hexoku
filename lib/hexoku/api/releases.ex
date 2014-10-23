defmodule Hexoku.API.Releases do
	alias Hexoku.Request
	@moduledoc """
	A release represents a combination of code, config vars and add-ons for an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#release)
	"""

	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/releases")

	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, release), do: Request.get(client, "/apps/#{app}/releases/#{release}")

	@spec create(Hexoku.Client.t, binary, binary) :: Map.t
	def create(client, app, slug, description \\ "Released using Hexoku") do
		Request.post(client, "/apps/#{app}/releases", %{slug: slug, description: description})
	end

	@spec rollback(Hexoku.Client.t, binary, binary) :: Map.t
	def rollback(client, app, release) do
		Request.post(client, "/apps/#{app}/releases", %{release: release})
	end

end
