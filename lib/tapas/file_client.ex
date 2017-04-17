defmodule Tapas.FileClient do
  def get_file(%Sipper.File{url: url}, _auth, callback: callback) do
    Sipper.DpdCartClient.get_external_file(url, callback)
  end
end
