defmodule Hexoku.API.Builds do
	alias Hexoku.Request
	@moduledoc """
	A build represents the process of transforming a code tarball into a slug

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#build)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, app) do
		Request.get(client, "/apps/#{app}/builds")
	end

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, build) do
		Request.get(client, "/apps/#{app}/builds/#{build}")
	end

	@spec create(Hexoku.Client.t, binary, binary, binary) :: Hexoku.Response.t
	def create(client, app, url, version) do
		Request.post(client, "/apps/#{app}/builds", %{source_blob: %{
			url: url,
			version: version
		}})
	end



end
