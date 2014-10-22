defmodule Hexoku.API.Formation do
	alias Hexoku.Request
	@moduledoc """
	The formation of processes that should be maintained for an app.
	Update the formation to scale processes or change dyno sizes.
	Available process type names and commands are defined by the process_types attribute for the slug currently
	released on an app.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#formation)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, app) do
		Request.get(client, "/apps/#{app}/formation")
	end

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, formation) do
		Request.get(client, "/apps/#{app}/formation/#{formation}")
	end

	@spec update(Hexoku.Client.t, binary, binary, integer, binary) :: Hexoku.Response.t
	def update(client, app, formation, quantity, size \\ "1X") do
		Request.patch(client, "/apps/#{app}/formation/#{formation}", %{
			quantity: quantity,
			size: size
		})
	end

	@spec batch_update(Hexoku.Client.t, binary, [Map.t]) :: Hexoku.Response.t
	def batch_update(client, app, updates) do
		Request.patch(client, "/apps/#{app}/formation", %{
			updates: updates
		})
	end



end
