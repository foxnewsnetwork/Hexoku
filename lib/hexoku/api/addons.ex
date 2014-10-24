defmodule Hexoku.API.Addons do
	alias Hexoku.Request
	@moduledoc """
	Add-ons represent add-ons that have been provisioned for an app.

	## Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of item generated by Heroku</dd>
		<dt>name</dt> <dd>unique name of item</dd>
		<dt>addon_service:id</dt> <dd>unique identifier of this addon-service</dd>
		<dt>addon_service:name</dt> <dd>unique name of this addon-service</dd>
		<dt>config_vars</dt> <dd>config vars associated with this application</dd>
		<dt>plan:id</dt> <dd>unique identifier of this plan</dd>
		<dt>plan:name</dt> <dd>unique name of this plan</dd>
		<dt>provider_id</dt> <dd>id of this add-on with its provider</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#add-on)
	"""

	@doc """
	List existing add-ons.

	## Examples
		client |> Hexoku.API.Addons.list("myapp")
	"""
	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/addons")

	@doc """
	Info for an existing add-on.

	## Examples
		client |> Hexoku.API.Addons.info("myapp", "heroku-postgresql-teal")
	"""
	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, addon), do: Request.get(client, "/apps/#{app}/addons/#{addon}")

	@doc """
	Create a new add-on.

	## Examples
		client |> Hexoku.API.Addons.create("myapp", "heroku-postgresql:dev")
		client |> Hexoku.API.Addons.create("myapp", "heroku-postgresql:dev", %{
			"db-version": "1.2.3"
		})
	"""
	@spec create(Hexoku.Client.t, binary, Map.t) :: Map.t
	def create(client, app, plan, config \\ %{}) do
		Request.post(client, "/apps/#{app}/addons", %{
			plan: plan,
			config: config
		})
	end

	@doc """
	Change add-on plan.

	Some add-ons may not support changing plans. In that case, an error will be returned.

	## Examples
		client |> Hexoku.API.Addons.update("myapp", "heroku-postgresql-teal", "heroku-postgresql:dev")
	"""
	@spec update(Hexoku.Client.t, binary, binary, binary) :: Map.t
	def update(client, app, addon, plan), do: Request.patch(client, "/apps/#{app}/addons/#{addon}", %{plan: plan})

	@doc """
	Delete an existing add-on.

	## Examples
		client |> Hexoku.API.Addons.delete("myapp", "heroku-postgresql-teal")
	"""
	@spec delete(Hexoku.Client.t, binary, binary) :: Map.t
	def delete(client, app, addon), do: Request.delete(client, "/apps/#{app}/addons/#{addon}")

	# TODO: Upgrade Helper
	# TODO: Downgrade Helper



end
