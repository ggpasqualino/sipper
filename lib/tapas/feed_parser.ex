defmodule Tapas.FeedParser do
  def parse(videos) do
    videos
    |> Poison.decode!
    |> Enum.map(&parse_item/1)
    |> Enum.sort_by(fn {name, _} -> name end, &Kernel.>=/2)
  end

  defp parse_item(%{"name" => name, "url" => url}) do
    {name, [%Sipper.File{name: name, url: url}]}
  end
end
