defmodule Mix.Tasks.Hexoku.Config do
  use Mix.Task
  alias Hexoku.API.Config
  alias Hexoku.Response

  @shortdoc "List Heroku configuration vars"
  @recursive true

  @doc """
  List config vars
  """
  def run([]) do
    client = Hexoku.toolbelt
    %Response{status: 200, body: config} = client |> Config.get(Mix.Tasks.Hexoku.app_name)
    Enum.each(config, fn {k, v} -> Mix.shell.info("#{k} = #{v}") end)
  end

end
