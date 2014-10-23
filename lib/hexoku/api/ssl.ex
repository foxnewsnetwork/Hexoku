defmodule Hexoku.API.SSL do
	alias Hexoku.Request
	@moduledoc """
	SSL Endpoint is a public address serving custom SSL cert for HTTPS traffic to a Heroku app. Note that an app must
	have the ssl:endpoint addon installed before it can provision an SSL Endpoint using these APIs.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#ssl-endpoint)
	"""

	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/ssl-endpoints")

	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, endpoint), do: Request.get(client, "/apps/#{app}/ssl-endpoints/#{endpoint}")

	@spec create(Hexoku.Client.t, binary, binary, boolean()) :: Map.t
	def create(client, app, certificate_chain, private_key, preprocess \\ true) do
		Request.post(client, "/apps/#{app}/ssl-endpoints", %{
			preprocess: preprocess,
			certificate_chain: certificate_chain,
			private_key: private_key
		})
	end

	@spec update(Hexoku.Client.t, binary, binary, Map.t) :: Map.t
	def update(client, app, endpoint, body), do: Request.patch(client, "/apps/#{app}/ssl-endpoints/#{endpoint}", body)

	@spec delete(Hexoku.Client.t, binary, binary) :: Map.t
	def delete(client, app, endpoint), do: Request.delete(client, "/apps/#{app}/ssl-endpoints/#{endpoint}")

end
