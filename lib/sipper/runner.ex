defmodule Sipper.Runner do
  @feed_parser Application.get_env(:sipper, :feed_parser)

  def run(config) do
    get_feed(config)
    |> parse_feed
    |> change_download_order(config.oldest_first)
    |> ignore_episodes(config.ignore)
    |> limit_to(config.max)
    |> download(config)
  end

  defp get_feed(config) do
    Sipper.FeedDownloader.run(config)
  end

  defp parse_feed(feed) do
    @feed_parser.parse(feed)
  end

  defp ignore_episodes(episodes, ignore_episodes) do
    Enum.reject(episodes, fn {title, _} ->
      Enum.any?(ignore_episodes, fn ignored -> String.contains?(title, ignored) end)
    end)
  end

  defp change_download_order(episodes, true),  do: Enum.reverse(episodes)
  defp change_download_order(episodes, false), do: episodes

  defp limit_to(episodes, :unlimited), do: episodes
  defp limit_to(episodes, max), do: episodes |> Enum.take(max)

  defp download(episodes, config) do
    Sipper.FileDownloader.run(episodes, config)
  end
end
