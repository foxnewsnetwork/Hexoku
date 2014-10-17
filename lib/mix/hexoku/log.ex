defmodule Mix.Tasks.Hexoku.Log do
	use Mix.Task
	alias Mix.Tasks.Hexoku, as: H
	alias Hexoku.API.LogSession
	@moduledoc false

	@shortdoc "Get Heroku apps log. [--tail] [--app APP]"
	@recursive true
	@switches [
		app: :string,
		tail: :boolean
	]

	def run(argv) do
		{options, _} = H.parse_options(argv, @switches)
		run(Keyword.get(options, :tail, false), options)
	end

	defp run(true, options) do
		client = Hexoku.toolbelt
		parent = self()
		client |> LogSession.stream(Keyword.get(options, :app), fn (chunk) ->
			send(parent, chunk)
		end)
		tail()
	end
	defp run(_, options) do
		client = Hexoku.toolbelt
		Mix.shell.info(client |> LogSession.get(Keyword.get(options, :app)))
	end

	defp tail() do
		receive do
			:done -> Mix.shell.info("Finished")
			chunk ->
				Mix.shell.info(String.strip(chunk))
				tail()
		end
	end

end
