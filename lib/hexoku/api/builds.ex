defmodule Hexoku.API.Builds do
	alias Hexoku.Request
	@moduledoc """
	A build represents the process of transforming a code tarball into a slug

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#build)
	"""

	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/builds")

	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, build), do: Request.get(client, "/apps/#{app}/builds/#{build}")

	@spec create(Hexoku.Client.t, binary, binary, binary) :: Map.t
	def create(client, app, url, version) do
		Request.post(client, "/apps/#{app}/builds", %{source_blob: %{
			url: url,
			version: version
		}})
	end



end
