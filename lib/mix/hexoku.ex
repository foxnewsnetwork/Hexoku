defmodule Mix.Tasks.Hexoku do
  use Mix.Task

  def app_name do
    Mix.Project.config[:heroku_app] || Mix.Project.config[:app]
  end

  @shortdoc "List Hexoku tasks"
  @moduledoc """
  List Hexoku tasks with help
  """
  def run([]) do
    help
  end

  def run(["--help"]) do
    help
  end

  defp help do
    Mix.shell.info """
    Help:

    mix hexoku.app                                # Get application info
    mix hexoku.config                             # List configuration variables
    mix hexoku --help                             # This help
    """
  end
end
