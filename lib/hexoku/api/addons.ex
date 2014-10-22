defmodule Hexoku.API.Addons do
	alias Hexoku.Request
	@moduledoc """
	Add-ons represent add-ons that have been provisioned for an app.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#add-on)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, app) do
		Request.get(client, "/apps/#{app}/addons")
	end

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, addon) do
		Request.get(client, "/apps/#{app}/addons/#{addon}")
	end

	@spec create(Hexoku.Client.t, binary, Map.t) :: Hexoku.Response.t
	def create(client, app, plan, config \\ %{}) do
		Request.post(client, "/apps/#{app}/addons", %{
			plan: plan,
			config: config
		})
	end

	@spec update(Hexoku.Client.t, binary, binary, binary) :: Hexoku.Response.t
	def update(client, app, addon, plan) do
		Request.patch(client, "/apps/#{app}/addons/#{addon}", %{plan: plan})
	end

	@spec delete(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def delete(client, app, addon) do
		Request.delete(client, "/apps/#{app}/addons/#{addon}")
	end

	# TODO: Upgrade Helper
	# TODO: Downgrade Helper



end
