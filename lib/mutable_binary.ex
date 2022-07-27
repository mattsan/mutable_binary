defmodule MutableBinary do
  alias MutableBinary.NIF

  @spec new(size :: pos_integer()) :: {:ok, reference()} | {:error, :invalid_size}
  def new(size) when size <= 0, do: {:error, :invalid_size}
  def new(size), do: NIF.new(size)

  @spec length(ref :: reference()) :: pos_integer()
  defdelegate length(ref), to: NIF

  @spec get(ref :: reference(), index :: non_neg_integer()) ::
          {:ok, byte()} | {:error, :out_of_range}
  def get(_, index) when index < 0, do: {:error, :out_of_range}
  def get(ref, index), do: NIF.get(ref, index)

  @spec set(ref :: reference(), index :: non_neg_integer(), value :: byte()) ::
          :ok | {:error, :out_of_range}
  def set(_, index, _) when index < 0, do: {:error, :out_of_range}
  def set(ref, index, value), do: NIF.set(ref, index, value)

  @spec to_string(ref :: reference()) :: binary()
  defdelegate to_string(ref), to: NIF
end
