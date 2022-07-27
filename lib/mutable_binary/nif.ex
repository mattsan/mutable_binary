defmodule MutableBinary.NIF do
  use Rustler, otp_app: :mutable_binary, crate: :mutable_binary_nif

  def add(_, _), do: :erlang.nif_error(:nif_not_loaded)
end
