defmodule Hexoku.API.Sources do
	alias Hexoku.Request
	@moduledoc """
	A source is a location for uploading and downloading an application’s source code.

	## Attributes
	<dl>
		<dt>source_blob:get_url</dt> <dd>URL to download the source</dd>
		<dt>source_blob:put_url</dt> <dd>URL to upload the source</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#source)
	"""

	@doc """
	Create URLs for uploading and downloading source.

	## Payload Attributes
	<dl>
		<dt>source_blob:get_url</dt> <dd>URL to download the source</dd>
		<dt>source_blob:put_url</dt> <dd>URL to upload the source</dd>
	</dl>

	## Examples
		client |> Hexoku.API.Sources.create("myapp")
		client |> Hexoku.API.Sources.create("myapp", %{ source_blob: %{
			get_url: "https://api.heroku.com/slugs/1234.tgz",
			put_url: "https://api.heroku.com/slugs/1234.tgz"
		}})
	"""
	@spec create(Hexoku.Client.t, binary, Map.t) :: Map.t
	def create(client, app, payload \\ %{}), do: Request.create(client, "/apps/#{app}/source", payload)


end
