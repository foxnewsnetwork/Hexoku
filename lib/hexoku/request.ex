defmodule Hexoku.Request do
	require HTTPoison.Base
	use HTTPoison.Base
	@moduledoc """
	Make generic Heroku HTTP requests.

	You can use this for making API requests to API endpoints that are still to be supported by Hexoku.

	## Examples:

		client = Hexoku.toolbelt
		client |> Hexoku.Request.get("/apps")

	"""

	@default_headers [
		{"User-Agent", "Hexouku"},
		{"Accept", "application/vnd.heroku+json; version=3"},
		{"Content-Type", "application/json"}
	]

	@spec get(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def get(client, path) do
		basic_request(client, :get, path, %{})
	end

	@spec head(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def head(client, path) do
		basic_request(client, :head, path, %{})
	end

	@spec post(Hexoku.Client.t, binary, map) :: Hexoku.Response.t
	def post(client, path, body) do
		basic_request(client, :post, path, body)
	end

	@spec put(Hexoku.Client.t, binary, map) :: Hexoku.Response.t
	def put(client, path, body) do
		basic_request(client, :put, path, body)
	end

	@spec patch(Hexoku.Client.t, binary, map) :: Hexoku.Response.t
	def patch(client, path, body) do
		basic_request(client, :patch, path, JSEX.encode!(body))
	end

	@spec delete(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def delete(client, path) do
		basic_request(client, :delete, path, "")
	end

	@spec options(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def options(client, path) do
		basic_request(client, :options, path, "")
	end

	defp process_response_body(""), do: ""
	defp process_response_body(body), do: JSEX.decode!(body, [{:labels, :binary}])

	defp response(status_code, _headers, body) do
		%Hexoku.Response{
			status: process_status_code(status_code),
			body: process_response_body(body)
		}
	end

	defp basic_request(client, method, path, body) when is_map(body) do
		basic_request(client, method, path, JSEX.encode!(body))
	end
	defp basic_request(%Hexoku.Client{auth: auth}, method, path, body) do
		auth_header = Hexoku.Client.Auth.Authenticate.auth_header(auth)
		headers = [auth_header|@default_headers]
		request(method, url(path), body, headers, [])
	end

	defp url(path) do
		cond do
			String.match?(path, ~r/\/pipeline/) -> "https://cisaurus.heroku.com" <> path
			true -> "https://api.heroku.com" <> path
		end
	end

end
