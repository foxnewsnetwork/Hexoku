defmodule Hexoku.API.Domains do
	alias Hexoku.Request
	@moduledoc """
	Domains define what web routes should be routed to an app on Heroku.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#domain)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, app) do
		Request.get(client, "/apps/#{app}/domains")
	end

	@spec info(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def info(client, app, domain) do
		Request.get(client, "/apps/#{app}/domains/#{domain}")
	end

	@spec create(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def create(client, app, domain) do
		Request.post(client, "/apps/#{app}/domains", %{domain: domain})
	end

	@spec delete(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def delete(client, app, domain) do
		Request.delete(client, "/apps/#{app}/domains/#{domain}")
	end

end
