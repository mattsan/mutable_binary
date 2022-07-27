defmodule MutableBinary.NIF do
  @moduledoc false

  use Rustler, otp_app: :mutable_binary, crate: :mutable_binary_nif

  def new(_), do: err()
  def length(_), do: err()
  def get(_, _), do: err()
  def set(_, _, _), do: err()
  def to_string(_), do: err()
  defp err, do: :erlang.nif_error(:nif_not_loaded)
end
