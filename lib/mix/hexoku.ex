defmodule Mix.Tasks.Hexoku do
  use Mix.Task
  @moduledoc """

  ## Heroku Mix Tasks:

    mix hexoku.app  [--app APP]                   # Get application info
    mix hexoku.config [--app APP]                 # List configuration variables
    mix hexoku.log [--app APP] [--tail]           # Show applications log
    mix hexoku --help                             # This help
  """
  @shortdoc "List Hexoku tasks"

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

  def run([]) do
    help
  end

  def run(["--help"]) do
    help
  end

  defp help do
    Mix.shell.info """
    Help:

    mix hexoku.app  [--app APP]                   # Get application info
    mix hexoku.config [--app APP]                 # List configuration variables
    mix hexoku.log [--app APP] [--tail]           # Show applications log
    mix hexoku --help                             # This help
    """
  end
end
