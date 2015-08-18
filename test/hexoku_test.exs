defmodule HexokuTest do
  use ExUnit.Case

  test "it should create a client" do
    client = Hexoku.toolbelt
    assert client
  end

  test "it should be able to create and destroy an app" do
    client = Hexoku.toolbelt
    app = client |> Hexoku.API.Apps.create(%{})
    assert app
    assert app["id"]

    dead = client |> Hexoku.API.Apps.delete(app["id"])
    assert dead["id"] == app["id"]
  end
end
