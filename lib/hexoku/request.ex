defmodule Hexoku.Request do

	defmodule RequestError, do: defexception status: nil, id: "undefined", message: ""
	defmodule ServerError, do: defexception status: nil, message: ""

	defmodule Requester do
		require HTTPoison.Base
		use HTTPoison.Base
		@moduledoc false

		defp process_response_body(""), do: ""
		defp process_response_body(body), do: JSEX.decode!(body, [{:labels, :binary}])

		defp response(status_code, _headers, body) do
			case process_status_code(status_code) do
				code when code >= 500 ->
					raise Hexoku.Request.ServerError code: code, body: body
				code when code >= 400 ->
					raise_error(code, process_response_body(body))
				_ -> process_response_body(body)
			end
		end

		defp raise_error(code, body) do
			raise Hexoku.Request.RequestError, code: code, id: body["body"], message: body["message"]
		end
	end

	@moduledoc """
	Make generic Heroku HTTP requests.

	You can use this for making API requests to API endpoints that are still to be supported by Hexoku.

	## Examples:

		client = Hexoku.toolbelt
		client |> Hexoku.Request.get("/apps")

	"""

	@default_headers [
		{"User-Agent", "#{Mix.Project.config[:app]}/#{Mix.Project.config[:version]}"},
		{"Accept", "application/vnd.heroku+json; version=3"},
		{"Content-Type", "application/json"}
	]
	## TODO: Find out if we can add parent Mix project and include in User-Agent.

	@doc """
		Perform a basic HTTP GET request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.get("/apps")
	"""
	@spec get(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def get(client, path), do: basic_request(client, :get, path, %{})

	@doc """
		Perform a basic HTTP HEAD request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.head("/apps")
	"""
	@spec head(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def head(client, path), do: basic_request(client, :head, path, %{})

	@doc """
		Perform a basic HTTP POST request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.post("/apps", %{foo: "bar"})
	"""
	@spec post(Hexoku.Client.t, binary, Map.t) :: Hexoku.Response.t
	def post(client, path, body), do: basic_request(client, :post, path, body)

	@doc """
		Perform a basic HTTP PUT request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.put("/apps/myapp", %{foo: "bar"})
	"""
	@spec put(Hexoku.Client.t, binary, Map.t) :: Hexoku.Response.t
	def put(client, path, body), do: basic_request(client, :put, path, body)

	@doc """
		Perform a basic HTTP PATCH request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.put("/apps/myapp", %{foo: "bar"})
	"""
	@spec patch(Hexoku.Client.t, binary, Map.t) :: Hexoku.Response.t
	def patch(client, path, body), do: basic_request(client, :patch, path, JSEX.encode!(body))

	@doc """
		Perform a basic HTTP DELETE request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.delete("/apps/myapp")
	"""
	@spec delete(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def delete(client, path), do: basic_request(client, :delete, path, "")

	@doc """
		Perform a basic HTTP OPTIONS request to the API endpoint.

		## Examples
			Hexoku.toolbelt |> Hexoku.Request.options("/apps/myapp")
	"""
	@spec options(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def options(client, path), do: basic_request(client, :options, path, "")


	defp basic_request(client, method, path, body) when is_map(body) do
		basic_request(client, method, path, JSEX.encode!(body))
	end
	defp basic_request(%Hexoku.Client{auth: auth}, method, path, body) do
		auth_header = Hexoku.Client.Auth.Authenticate.auth_header(auth)
		headers = [auth_header|@default_headers]
		Requester.request(method, url(path), body, headers, [])
	end

	defp url(path) do
		cond do
			String.match?(path, ~r/\/pipeline/) -> "https://cisaurus.heroku.com" <> path
			true -> "https://api.heroku.com" <> path
		end
	end

end
