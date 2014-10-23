defmodule Hexoku.API.Account.Keys do
	alias Hexoku.Request
	@moduledoc """
	Keys represent public SSH keys associated with an account and are used to
	authorize accounts as they are performing git operations.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#key)
	"""

	@spec list(Hexoku.Client.t) :: [Map.t]
	def list(client), do: Request.get(client, "/account/keys")

	@spec info(Hexoku.Client.t, binary) :: Map.t
	def info(client, key_id_or_fingerprint), do: Request.get(client, "/account/keys/#{key_id_or_fingerprint}")

	@spec create(Hexoku.Client.t, binary) :: Map.t
	def create(client, public_key), do: Request.post(client, "/account/keys", %{public_key: public_key})

	@spec delete(Hexoku.Client.t, binary) :: Map.t
	def delete(client, key_id_or_fingerprint), do: Request.delete(client, "/account/keys/#{key_id_or_fingerprint}")

end
