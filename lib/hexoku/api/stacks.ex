defmodule Hexoku.API.Stacks do
	alias Hexoku.Request
	@moduledoc """
	Stacks are the different application execution environments available in the Heroku platform.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#stack)
	"""

	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/stacks")

	@spec info(Hexoku.Client.t, binary) :: Map.t
	def info(client, stack), do: Request.get(client, "/stacks/#{stack}")

end
