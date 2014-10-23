defmodule Mix.Tasks.Hexoku.Config do
  use Mix.Task
  alias Mix.Tasks.Hexoku, as: H
  alias Hexoku.API.Config
  @moduledoc false

  @shortdoc "List Heroku configuration vars [--app APP]"
  @recursive true
  @switches [
    app: :string
  ]

  def run(argv) do
    {options, _} = H.parse_options(argv, @switches)
    client = Hexoku.toolbelt
    config = client |> Config.list(Keyword.get(options, :app))
    Enum.each(config, fn {k, v} -> Mix.shell.info("#{k} = #{v}") end)
  end

end
