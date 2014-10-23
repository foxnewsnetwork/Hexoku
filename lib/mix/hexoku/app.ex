defmodule Mix.Tasks.Hexoku.App do
	use Mix.Task
	alias Mix.Tasks.Hexoku, as: H
	alias Hexoku.API.Apps
	alias Hexoku.API.Formation
	@moduledoc false

	@shortdoc "Get application info [--app APP]"
	@recursive true
	@switches [
		app: :string
	]

	def run(argv) do
		{options, _} = H.parse_options(argv, @switches)
		client = Hexoku.toolbelt

		Mix.shell.info("App Name:       #{Keyword.get(options, :app)}")
		info = client |> Apps.info(Keyword.get(options, :app))
		Mix.shell.info("Region:         #{info["region"]["name"]}")
		Mix.shell.info("Stack:          #{info["stack"]["name"]}")
		Mix.shell.info("Created:        #{info["created_at"]}")
		Mix.shell.info("Updated:        #{info["updated_at"]}")
		Mix.shell.info("Released:       #{info["released_at"]}")
		Mix.shell.info("URL:            #{info["web_url"]}")

		formations = client |> Formation.list(Keyword.get(options, :app))
		Mix.shell.info("\nFormation:")
		for formation <- formations do
			Mix.shell.info("  #{formation["quantity"]} x #{formation["type"]}: #{formation["command"]} (#{formation["size"]})")
		end

		if info[:maintenance] == true do
			Mix.shell.error("Application is in maintenance mode")
		end
	end

end
