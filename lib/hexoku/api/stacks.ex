defmodule Hexoku.API.Stacks do
	alias Hexoku.Request
	@moduledoc """
	Stacks are the different application execution environments available in the Heroku platform.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#stack)
	"""

	@spec list(Hexoku.Client.t) :: Hexoku.Response.t
	def list(client) do
		Request.get(client, "/stacks")
	end

	@spec info(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def info(client, stack) do
		Request.get(client, "/stacks/#{stack}")
	end

end
