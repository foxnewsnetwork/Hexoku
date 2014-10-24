defmodule Hexoku.API.Dynos do
	alias Hexoku.Request
	@moduledoc """
	Dynos encapsulate running processes of an app on Heroku.

	## Attributes
	<dl>
		<dt>id</dt> <dd>unique identifier of item generated by Heroku</dd>
		<dt>name</dt> <dd>the name of this process on this dyno</dd>
		<dt>attach_url</dt> <dd>a URL to stream output from for attached processes or null for non-attached processes</dd>
		<dt>command</dt> <dd>command used to start this process</dd>
		<dt>release:id</dt> <dd>unique identifier of release</dd>
		<dt>release:version</dt> <dd>unique version assigned to the release</dd>
		<dt>size</dt> <dd>dyno size (default: "1X")</dd>
		<dt>state</dt> <dd>current status of process [crashed, down, idle, starting, up]</dd>
		<dt>type</dt> <dd>type of process</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#dyno)
	"""

	@doc """
	List existing dynos.

	## Examples
		client |> Hexoku.API.Dynos.list("myapp")
	"""
	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, app), do: Request.get(client, "/apps/#{app}/dynos")

	@doc """
	Info for existing dyno.

	## Examples
		client |> Hexoku.API.Dynos.info("myapp", "web.1")
	"""
	@spec info(Hexoku.Client.t, binary, binary) :: Map.t
	def info(client, app, dyno), do: Request.get(client, "/apps/#{app}/dynos/#{dyno}")

	@doc """
	Create a new dyno.

	## Payload Attributes
	<dl>
		<dt>command <em>required</em></dt> <dd>command used to start this process</dd>
		<dt>attach</dt> <dd>whether to stream output or not</dd>
		<dt>env</dt> <dd>Dict of vars to add to the dyno config vars</dd>
		<dt>size</dt> <dd>dyno size (default: "1X")</dd>
	</dl>

	## Examples
		client |> Hexoku.API.Dynos.create("myapp", %{
			command: "mix test",
			env: %{"MIX_ENV": "test"}
		})
	"""
	@spec create(Hexoku.Client.t, binary, binary, Map.t) :: Map.t
	def create(client, app, command, options \\ %{}) do
		body = Dict.put(options, :command, command)
		Request.post(client, "/apps/#{app}/dynos", body)
	end

	@doc """
	Restart specific dyno.

	## Examples
		client |> Hexoku.API.Dynos.restart("myapp", "web.1")
	"""
	@spec restart(Hexoku.Client.t, binary, binary) :: Map.t
	def restart(client, app, dyno), do: Request.delete(client, "/apps/#{app}/dynos/#{dyno}")

	@doc """
	Restart all dynos.

	## Examples
		client |> Hexoku.API.Dynos.restart_all("myapp")
	"""
	@spec restart_all(Hexoku.Client.t, binary) :: Map.t
	def restart_all(client, app), do: Request.delete(client, "/apps/#{app}/dynos")

end
