defmodule Tapas.FeedClient do
  use Hound.Helpers

  @host "https://www.rubytapas.com"
  @login_page "#{@host}/login/"
  @feed_page "#{@host}/download-list"

  def get_feed({user, password} = auth) do
    with_hound(fn ->
      login(user, password)
      get_video_links()
    end)
  end

  defp with_hound(f) do
    Application.ensure_all_started(:hound)
    Hound.start_session
    result = f.()
    Hound.end_session

    result
  end

  defp login(user, password) do
    navigate_to @login_page
    fill_field {:name, "log"}, user
    fill_field {:name, "pwd"}, password
    submit_element {:name, "wp-submit"}
  end

  defp get_video_links do
    navigate_to @feed_page

    :class
    |> find_all_elements("mepr-aws-link")
    |> Enum.map(&to_video/1)
    |> Poison.encode!
  end

  defp to_video(anchor_element) do
    url = attribute_value(anchor_element, "href")
    name = anchor_element |> inner_html() |> String.trim()
    %{name: name, url: url}
  end
end
