defmodule MutableBinaryTest do
  use ExUnit.Case
  doctest MutableBinary

  setup context do
    {:ok, ref} = MutableBinary.new(Map.get(context, :size, 16))

    [ref: ref]
  end

  describe "new/1 " do
    test "size is positive" do
      assert {:ok, ref} = MutableBinary.new(123)
      assert MutableBinary.length(ref) == 123
    end

    test "size is zero" do
      assert {:error, :invalid_size} = MutableBinary.new(0)
    end

    test "size is negative" do
      assert {:error, :invalid_size} = MutableBinary.new(-1)
    end
  end

  describe "length/1" do
    @tag size: 1
    test "length is 1", %{ref: ref} do
      assert MutableBinary.length(ref) == 1
    end

    @tag size: 1024
    test "length is 1024", %{ref: ref} do
      assert MutableBinary.length(ref) == 1024
    end
  end

  describe "get/2 and set/3" do
    (0..15)
    |> Enum.each(fn i ->
      @tag index: i
      test "set 123 at index #{i} and get it", %{ref: ref, index: index} do
        assert {:ok, 0} = MutableBinary.get(ref, index)
        assert :ok = MutableBinary.set(ref, index, 123)
        assert {:ok, 123} = MutableBinary.get(ref, index)
      end
    end)
  end

  describe "get/2" do
    test "too large index", %{ref: ref} do
      assert {:error, :out_of_range} = MutableBinary.get(ref, 16)
    end

    test "too small index", %{ref: ref} do
      assert {:error, :out_of_range} = MutableBinary.get(ref, -1)
    end
  end

  describe "set/3" do
    test "too large index", %{ref: ref} do
      assert {:error, :out_of_range} = MutableBinary.set(ref, 16, 0)
    end

    test "too small index", %{ref: ref} do
      assert {:error, :out_of_range} = MutableBinary.set(ref, -1, 0)
    end
  end

  describe "to_string/1" do
    test "MutableBinary to string", %{ref: ref} do
      assert MutableBinary.to_string(ref) == <<0::128>>

      assert :ok = MutableBinary.set(ref, 0, ?m)
      assert :ok = MutableBinary.set(ref, 1, ?u)
      assert :ok = MutableBinary.set(ref, 2, ?t)
      assert :ok = MutableBinary.set(ref, 3, ?a)
      assert :ok = MutableBinary.set(ref, 4, ?b)
      assert :ok = MutableBinary.set(ref, 5, ?l)
      assert :ok = MutableBinary.set(ref, 6, ?e)
      assert :ok = MutableBinary.set(ref, 7, ?\s)
      assert :ok = MutableBinary.set(ref, 8, ?b)
      assert :ok = MutableBinary.set(ref, 9, ?i)
      assert :ok = MutableBinary.set(ref, 10, ?n)
      assert :ok = MutableBinary.set(ref, 11, ?a)
      assert :ok = MutableBinary.set(ref, 12, ?r)
      assert :ok = MutableBinary.set(ref, 13, ?y)
      assert :ok = MutableBinary.set(ref, 14, ??)
      assert :ok = MutableBinary.set(ref, 15, ?!)

      assert MutableBinary.to_string(ref) == "mutable binary?!"
    end
  end
end
