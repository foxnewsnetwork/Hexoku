defmodule Hexoku.API.Slugs do
	alias Hexoku.Request
	@moduledoc """
	A slug is a snapshot of your application code that is ready to run on the platform.

	## Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of slug</dd>
		<dt>blob:method</dt> <dd>method to be used to interact with the slug blob</dd>
		<dt>blob:url</dt> <dd>URL to interact with the slug blob</dd>
		<dt>buildpack_provided_description</dt> <dd>description from buildpack of slug</dd>
		<dt>commit</dt> <dd>identification of the code with your version control system (eg: SHA of the git HEAD)</dd>
		<dt>process_types</dt> <dd>hash mapping process type names to their respective command</dd>
		<dt>size</dt> <dd>size of slug, in bytes</dd>
		<dt>stack:id</dt> <dd>unique identifier of stack</dd>
		<dt>stack:name</dt> <dd>name of stack</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#slug)
	"""

	@doc """
	Info for existing slug.

	## Examples
		client |> Hexoku.API.Slugs.info("myapp", "01234567-89ab-cdef-0123-456789abcdef")
	"""
	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, slug), do: Request.get(client, "/apps/#{app}/slugs/#{slug}")

	@doc """
	Create a new slug. For more information please refer to
	[Deploying Slugs using the Platform API](https://devcenter.heroku.com/articles/platform-api-deploying-slugs?preview=1).

	## Payload Attributes
	<dl>
		<dt>process_types <em>required</em></dt> <dd>Dict of process type names to their respective command</dd>
		<dt>buildpack_provided_description</dt> <dd>description from buildpack of slug</dd>
		<dt>commit</dt> <dd>identification of the code with your version control system (eg: SHA of the git HEAD)</dd>
		<dt>stack</dt> <dd>unique identifier or name of stack</dd>
	</dl>

	## Examples
		client |> Hexoku.API.Slugs.create("myapp", %{
			buildpack_provided_description: "Ruby/Rack",
			commit: "60883d9e8947a57e04dc9124f25df004866a2051",
			process_types: %{web: "./bin/web -p $PORT"}
		})
	"""
	@spec create(Hexoku.Client.t, binary, Map.t) :: Map.t
	def create(client, app, payload), do: Request.post(client, "/apps/#{app}/slugs", payload)

end
