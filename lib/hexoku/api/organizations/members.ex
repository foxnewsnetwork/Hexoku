defmodule Hexoku.API.Organizations.Members do
	alias Hexoku.Request
	@moduledoc """
	An organization member is an individual with access to an organization

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#organization-member)
	"""

	@spec list(Hexoku.Client.t, binary) :: Hexoku.Response.t
	def list(client, org) do
		Request.get(client, "/organizations/#{org}/members")
	end

	@spec grant(Hexoku.Client.t, binary, binary, binary) :: Hexoku.Response.t
	def grant(client, org, email, role \\ "member") do
		Request.put(client, "/organizations/#{org}/members", %{
			email: email,
			role: role
		})
	end

	@spec remove(Hexoku.Client.t, binary, binary) :: Hexoku.Response.t
	def remove(client, org, email) do
		Request.delete(client, "/organizations/#{org}/members/#{email}")
	end

end
