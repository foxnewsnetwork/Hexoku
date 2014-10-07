defmodule Mix.Tasks.Hexoku.Log do
	use Mix.Task
	alias Hexoku.API.LogSession
	@moduledoc false

	@shortdoc "Get Heroku apps log. [--tail]"
	@recursive true

	@doc """
	Get Heroku apps log.
	"""
	def run([]) do
		client = Hexoku.toolbelt
		Mix.shell.info(client |> LogSession.get(Mix.Tasks.Hexoku.app_name))
	end
	def run(["--tail"]) do
		client = Hexoku.toolbelt
		parent = self()
		client |> LogSession.stream(Mix.Tasks.Hexoku.app_name, fn (chunk) ->
			send(parent, chunk)
		end)
		tail()
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
