defmodule Hexoku.API.Addons.Available do
	alias Hexoku.Request
	@moduledoc """
	Add-on Services represent add-ons that may be provisioned for apps.
	Plans represent different configurations of add-ons that may be added to apps.

	## Add-on Services Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of this addon-service</dd>
		<dt>name</dt> <dd>unique name of this addon-service</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#add-on-service)

	## Plan Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of item</dd>
		<dt>name</dt> <dd>name of this plan</dd>
		<dt>default</dt> <dd>whether this plan is the default for its addon service</dd>
		<dt>description</dt> <dd>description of plan</dd>
		<dt>price:cents</dt> <dd>price in cents per unit of plan</dd>
		<dt>price:unit</dt> <dd>unit of price for plan</dd>
		<dt>state</dt> <dd>release status for plan</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#plan)
	"""

	@doc """
	List existing addon-services.

	## Examples
		client |> Hexoku.API.Addons.Available.list()
	"""
	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/addon-services")

	@doc """
	Info for existing addon-service.

	## Examples
		client |> Hexoku.API.Addons.Available.info("heroku-postgresql")
	"""
	@spec info(Hexoku.Client.t, binary) :: Map.t
	def info(client, service), do: Request.get(client, "/addon-services/#{service}")

	@doc """
	List existing plans.

	## Examples
		client |> Hexoku.API.Addons.Available.plans("heroku-postgresql")
	"""
	@spec plans(Hexoku.Client.t, binary) :: [Map.t]
	def plans(client, service), do: Request.get(client, "/addon-services/#{service}/plans")

	@doc """
	Info for existing plan.

	## Examples
		client |> Hexoku.API.Addons.Available.plan_info("heroku-postgresql", "heroku-postgresql:dev")
	"""
	@spec plan_info(Hexoku.Client.t, binary, binary) :: Map.t
	def plan_info(client, service, plan), do: Request.get(client, "/addon-services/#{service}/plans/#{plan}")

end
