defmodule Sipper.FeedDownloader do
  @feed_client Application.get_env(:sipper, :feed_client)

  def run(config) do
    case Sipper.FeedCache.read do
      {:ok, cached_feed} ->
        IO.puts "Using cached feed."
        cached_feed
      _ ->
        Sipper.ProgressBar.render_spinner "Getting feed…", "Got feed.", fn ->
          feed = @feed_client.get_feed(config.auth)
          Sipper.FeedCache.write(feed)
          feed
        end
    end
  end
end
