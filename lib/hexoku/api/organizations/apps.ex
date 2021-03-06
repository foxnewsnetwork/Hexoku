defmodule Hexoku.API.Organizations.Apps do
	alias Hexoku.Request
	@moduledoc """
	An organization app encapsulates the organization specific functionality of Heroku apps.

	## Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of app generated by Heroku</dd>
		<dt>name</dt> <dd>unique name of app provided by the user</dd>
		<dt>build_stack:id</dt> <dd>unique identifier of stack</dd>
		<dt>build_stack:name</dt> <dd>unique name of stack</dd>
		<dt>buildpack_provided_description</dt> <dd>description from buildpack of app</dd>
		<dt>git_url</dt> <dd>git repo URL of app</dd>
		<dt>maintenance</dt> <dd>maintenance status of app</dd>
		<dt>organization</dt> <dd>organization that owns this app</dd>
		<dt>organization:name</dt> <dd>unique name of organization</dd>
		<dt>locked</dt> <dd>are other organization members forbidden from joining this app.</dd>
		<dt>joined</dt> <dd>is the current member a collaborator on this app.</dd>
		<dt>owner:email</dt> <dd>email address of account</dd>
		<dt>owner:id</dt> <dd>unique identifier of owner</dd>
		<dt>region:id</dt> <dd>unique identifier of region</dd>
		<dt>region:name</dt> <dd>unique name of region</dd>
		<dt>repo_size</dt> <dd>git repo size in bytes of app</dd>
		<dt>slug_size</dt> <dd>slug size in bytes of app</dd>
		<dt>stack:id</dt> <dd>unique identifier of stack</dd>
		<dt>stack:name</dt> <dd>unique name of stack</dd>
		<dt>web_url</dt> <dd>web URL of app</dd>
		<dt>archived_at</dt> <dd>when app was archived</dd>
		<dt>released_at</dt> <dd>when app was released</dd>
		<dt>created_at</dt> <dd>when app was created</dd>
		<dt>updated_at</dt> <dd>when app was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#organization-app)
	"""

	@doc """
	List apps in the default organization, or in personal account, if default organization is not set.

	## Examples
		client |> Hexoku.API.Organizations.Apps.list()
	"""
	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/organizations/apps")

	@doc """
	List organization apps.

	## Examples
		client |> Hexoku.API.Organizations.Apps.list("myorg")
	"""
	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, org), do: Request.get(client, "/organizations/#{org}/apps")

	# TODO: Organization App Info
	# TODO: Organization App Create
	# TODO: Organization App Lock
	# TODO: Organization App Transfer to Account

end
