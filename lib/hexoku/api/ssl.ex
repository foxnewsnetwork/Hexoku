defmodule Hexoku.API.SSL do
	alias Hexoku.Request
	@moduledoc """
	SSL Endpoint is a public address serving custom SSL cert for HTTPS traffic to a Heroku app. Note that an app must
	have the ssl:endpoint addon installed before it can provision an SSL Endpoint using these APIs.

	## Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of item generated by Heroku</dd>
		<dt>name</dt> <dd>unique name of item provided by the user</dd>
		<dt>certificate_chain</dt> <dd>raw contents of the public certificate chain (eg: .crt or .pem file)</dd>
		<dt>cname</dt> <dd>canonical name record, the address to point a domain at</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#ssl-endpoint)
	"""

	@doc """
	List existing SSL endpoints.

	## Examples
		client |> Hexoku.API.SSL.list("myapp")
	"""
	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/ssl-endpoints")

	@doc """
	Info for existing SSL endpoint.

	## Examples
		client |> Hexoku.API.SSL.info("myapp", "example")
	"""
	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, endpoint), do: Request.get(client, "/apps/#{app}/ssl-endpoints/#{endpoint}")

	@doc """
	Helper to create a new SSL endpoint.

	## Examples
		client |> Hexoku.API.SSL.create(
			"myapp",
			"-----BEGIN CERTIFICATE----- ...",
			"-----BEGIN RSA PRIVATE KEY----- ..."
		)
	"""
	@spec create(Hexoku.Client.t, binary, binary, boolean()) :: Map.t
	def create(client, app, certificate_chain, private_key) do
		Request.post(client, "/apps/#{app}/ssl-endpoints", %{
			certificate_chain: certificate_chain,
			private_key: private_key
		})
	end

	@doc """
	Create a new SSL endpoint.

	## Payload Attributes
	<dl>
		<dt>certificate_chain <em>required</em></dt> <dd>raw contents of the public certificate chain
			(eg: .crt or .pem file)</dd>
		<dt>cname <em>required</em></dt> <dd>canonical name record, the address to point a domain at</dd>
		<dt>preprocess</dt> <dd>allow Heroku to modify an uploaded public certificate chain if deemed advantageous by
			adding missing intermediaries, stripping unnecessary ones, etc. default: true</dd>
	</dl>

	## Examples
		client |> Hexoku.API.SSL.create("myapp", "example", %{
			certificate_chain: "-----BEGIN CERTIFICATE----- ...",
			private_key: "-----BEGIN RSA PRIVATE KEY----- ..."
		})
	"""
	@spec create(Hexoku.Client.t, binary, Map.t) :: Map.t
	def create(client, app, payload), do: Request.post(client, "/apps/#{app}/ssl-endpoints", payload)

	@doc """
	Update an existing SSL endpoint.

	## Payload Attributes
	<dl>
		<dt>certificate_chain <em>required</em></dt> <dd>raw contents of the public certificate chain
			(eg: .crt or .pem file)</dd>
		<dt>cname <em>required</em></dt> <dd>canonical name record, the address to point a domain at</dd>
		<dt>preprocess</dt> <dd>allow Heroku to modify an uploaded public certificate chain if deemed advantageous by
			adding missing intermediaries, stripping unnecessary ones, etc. default: true</dd>
		<dt>rollback</dt> <dd>indicates that a rollback should be performed</dd>
	</dl>

	## Examples
		client |> Hexoku.API.SSL.update("myapp", "example", %{
			certificate_chain: "-----BEGIN CERTIFICATE----- ...",
			private_key: "-----BEGIN RSA PRIVATE KEY----- ..."
		})
	"""
	@spec update(Hexoku.Client.t, binary, binary, Map.t) :: Map.t
	def update(client, app, endpoint, payload), do: Request.patch(client, "/apps/#{app}/ssl-endpoints/#{endpoint}", payload)

	@doc """
	Delete existing SSL endpoint.

	## Examples
		client |> Hexoku.API.SSL.delete("myapp", "example")
	"""
	@spec delete(Hexoku.Client.t, binary, binary) :: Map.t
	def delete(client, app, endpoint), do: Request.delete(client, "/apps/#{app}/ssl-endpoints/#{endpoint}")

end
