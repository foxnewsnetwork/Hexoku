defmodule Hexoku.API.Organizations.Members do
	alias Hexoku.Request
	@moduledoc """
	An organization member is an individual with access to an organization

	## Attributes
	<dl>
		<dt>email</dt> <dd>email address of the organization member</dd>
		<dt>role</dt> <dd>role in the organization ["admin", "member", "collaborator"]</dd>
		<dt>created_at</dt> <dd>when item was created</dd>
		<dt>updated_at</dt> <dd>when item was last modified</dd>
	</dl>

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#organization-member)
	"""

	@doc """
	List members of the organization.

	## Examples
		client |> Hexoku.API.Organizations.Members.list("myorg")
	"""
	@spec list(Hexoku.Client.t, binary) :: [Map.t]
	def list(client, org), do: Request.get(client, "/organizations/#{org}/members")

	@doc """
	Create a new organization member, or update their role.

	## Examples
		client |> Hexoku.API.Organizations.Members.grant("myorg", "email@example.com", "member")
	"""
	@spec grant(Hexoku.Client.t, binary, binary, binary) :: Map.t
	def grant(client, org, email, role \\ "member") do
		Request.put(client, "/organizations/#{org}/members", %{
			email: email,
			role: role
		})
	end

	@doc """
	Remove a member from the organization.

	## Examples
		client |> Hexoku.API.Organizations.Members.remove("myorg", "email@example.com")
	"""
	@spec remove(Hexoku.Client.t, binary, binary) :: Map.t
	def remove(client, org, email), do: Request.delete(client, "/organizations/#{org}/members/#{email}")

end
