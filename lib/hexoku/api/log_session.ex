defmodule Hexoku.API.LogSession do
	alias Hexoku.Request
	@moduledoc """
	Read the application logs.

	For more info read the [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference#log-session)
	"""

	@spec get(Hexoku.Client.t, binary, Map.t) :: binary | :error
	def get(client, app, options \\ %{}) do
		%Hexoku.Response{status: 201, body: body} = Request.post(client, "/apps/#{app}/log-sessions", %{})
		sender = self()
		pid = spawn(fn -> collect_stream(sender, body[:logplex_url]) end)
		receive do
			{^pid, chunk} -> chunk
		after 6000 -> throw {:error, :timeout}
		end
	end

	@spec stream(Hexoku.Client.t, binary, Map.t, (binary | :done -> any)) :: :ok
	def stream(client, app, options \\ %{}, fun) do
		%Hexoku.Response{status: 201, body: body} = Request.post(client, "/apps/#{app}/log-sessions", %{tail: true})
		get_stream(body[:logplex_url], fun)
	end

	defp collect_stream(sender, url) do
		me = self()
		get_stream(url, fn (data) -> send(me, data) end)
		collect_stream_loop(sender, "")
	end

	defp collect_stream_loop(sender, acc) do
		receive do
			:done -> send(sender, {self(), acc})
			chunk -> collect_stream_loop(sender, acc<>chunk)
		after 5000 -> throw :timeout
		end
	end

	defp get_stream(url, fun) do
		pid = spawn(fn -> get_stream_loop(fun) end)
		HTTPoison.get(url, [], [stream_to: pid])
		pid
	end
	defp get_stream_loop(fun) do
		receive do
			%HTTPoison.AsyncEnd{} -> fun.(:done)
			%HTTPoison.AsyncChunk{chunk: {:error, {:closed, chunk}}} ->
				fun.(chunk)
				fun.(:done)
			%HTTPoison.AsyncChunk{chunk: {:error, _}} -> fun.(:done)
			%HTTPoison.AsyncChunk{chunk: chunk} ->
				fun.(chunk)
				get_stream_loop(fun)
			_ -> get_stream_loop(fun)
		end
	end



end
