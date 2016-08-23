defmodule Math.Power.Test do
  use ExUnit.Case

  @significance 15

  # On my machine, iterations over 12 bring bad karma
  @iterations   12

  Enum.each 1..@iterations, fn n ->
    test "Confirm Cldr.Math.power(5, n) for #{inspect n} returns the same result as :math.pow" do
      p = Cldr.Number.Math.power(5, unquote(n))
      |> Cldr.Number.Math.round_significant(@significance)

      q = :math.pow(5, unquote(n))
      |> Cldr.Number.Math.round_significant(@significance)
      assert p == q
    end

    # Decimal number, decimal power
    test "Confirm Decimal Cldr.Math.power(5, n) for Decimal #{inspect n} returns the same result as :math.pow" do
      p = Cldr.Number.Math.power(Decimal.new(5), Decimal.new(unquote(n)))
      |> Cldr.Number.Math.round_significant(10)
      |> Decimal.to_integer

      q = :math.pow(5, unquote(n))
      |> Cldr.Number.Math.round_significant(10)
      |> trunc()

      assert p == q
    end
  end
end