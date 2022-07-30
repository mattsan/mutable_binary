# sample.exs

{:ok, ref} = MutableBinary.NIF.new(16)

MutableBinary.NIF.length(ref) |> IO.inspect(label: "length")
MutableBinary.NIF.to_string(ref) |> IO.inspect(label: "to_string")

MutableBinary.NIF.get(ref, 0) |> IO.inspect(label: "get [0]")
MutableBinary.NIF.set(ref, 0, 123) |> IO.inspect(label: "set [0] <- 123")
MutableBinary.NIF.get(ref, 0) |> IO.inspect(label: "get [0]")
MutableBinary.NIF.get(ref, 16) |> IO.inspect(label: "get [16]")

MutableBinary.NIF.set(ref, 0, 69)
MutableBinary.NIF.set(ref, 1, 108)
MutableBinary.NIF.set(ref, 2, 105)
MutableBinary.NIF.set(ref, 3, 120)
MutableBinary.NIF.set(ref, 4, 105)
MutableBinary.NIF.set(ref, 5, 114)
MutableBinary.NIF.set(ref, 6, 33)
MutableBinary.NIF.set(ref, 7, 32)
MutableBinary.NIF.set(ref, 8, 38)
MutableBinary.NIF.set(ref, 9, 32)
MutableBinary.NIF.set(ref, 10, 82)
MutableBinary.NIF.set(ref, 11, 117)
MutableBinary.NIF.set(ref, 12, 115)
MutableBinary.NIF.set(ref, 13, 116)
MutableBinary.NIF.set(ref, 14, 33)
MutableBinary.NIF.set(ref, 15, 33)

MutableBinary.NIF.to_string(ref) |> IO.inspect(label: "to_string")
