defmodule Mix.Tasks.Hexoku do
	use Mix.Task
	@moduledoc """

	Hexoku adds some common Heroku commands to your Mix. It relies on [Heroku Toolbet](toolbelt.heroku.com) being
	installed and logged in.

	The application name is read from the heroku_app key in your `mix.exs` files project.
	If that is not defined it falls back to the :app key.

		def project do
			[
				app: :uberweb,
				heroku_app: "uberweb-staging"
				version: "0.0.1",
				elixir: "~> 1.0.0",
				deps: deps
			]
		end

	### Examples

		bash> mix hexoku.config
			DOWNSTREAM_APP = myapp-production
			REDIS_HOST = somehost.redistogo.com


	## Heroku Mix Tasks:

		mix hexoku.app	[--app APP]             # Get application info
		mix hexoku.config [--app APP]           # List configuration variables
		mix hexoku.log [--app APP] [--tail]     # Show applications log
		mix hexoku --help                       # This help
	"""
	@shortdoc "List Hexoku tasks"

	@doc false
	def parse_options(argv, switches) do
		{parsed, argv, errors} = OptionParser.parse(argv, strict: switches)
		unless Keyword.get(parsed, :app, false) do
			app = Mix.Project.config[:heroku_app] || Mix.Project.config[:app]
			parsed = Keyword.put(parsed, :app, app)
		end
		if length(errors) > 0 do
			for {flag, _} <- errors, do: Mix.shell.error("Error with flag "<>flag)
			System.halt(1)
		else
			{parsed, argv}
		end
	end

	@doc false
	def run([]) do
		help
	end

	def run(["--help"]) do
		help
	end

	defp help do
		Mix.shell.info """
		Help:

		mix hexoku.app	[--app APP]									 # Get application info
		mix hexoku.config [--app APP]								 # List configuration variables
		mix hexoku.log [--app APP] [--tail]					 # Show applications log
		mix hexoku --help														 # This help
		"""
	end
end
