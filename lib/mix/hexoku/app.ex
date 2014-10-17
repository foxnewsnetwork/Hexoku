defmodule Mix.Tasks.Hexoku.App do
	use Mix.Task
	alias Mix.Tasks.Hexoku, as: H
	alias Hexoku.API.Apps
	alias Hexoku.Response
	@moduledoc false

	@shortdoc "Get application info [--app APP]"
	@recursive true
	@switches [
		app: :string
	]

	def run(argv) do
		{options, _} = H.parse_options(argv, @switches)
		client = Hexoku.toolbelt
		%Response{status: 200, body: info} = client |> Apps.info(Keyword.get(options, :app))
		Mix.shell.info("App Name:       #{info[:name]}")
		Mix.shell.info("Region:         #{info[:region][:name]}")
		Mix.shell.info("Stack:          #{info[:stack][:name]}")
		Mix.shell.info("Created:        #{info[:created_at]}")
		Mix.shell.info("Updated:        #{info[:updated_at]}")
		Mix.shell.info("Released:       #{info[:released_at]}")
		Mix.shell.info("URL:            #{info[:web_url]}")
		if info[:maintenance] == true do
			Mix.shell.error("Application is in maintenance mode")
		end
	end

end
