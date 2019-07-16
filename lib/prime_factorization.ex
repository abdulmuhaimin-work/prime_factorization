defmodule PrimeFactorization do
  @moduledoc """
  Documentation for PrimeFactorization.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PrimeFactorization.hello()
      :world

  """

  import Primes


  def prime_numbers_factors(anything) do
    nombor = case parse_input(anything) do
      {:ok, parsed_number} -> parsed_number
      {:error, err_message} -> IO.puts(err_message)
    end

    cond do
      is_integer(nombor) -> division_check(nombor)
      true -> IO.puts("please try again")
    end
  end

   def parse_input(input) do
     cond do
       is_integer(input) and input > largest_prime()*largest_prime() -> {:error, "number is too large. It only accept number below #{largest_prime()*largest_prime()}"}
       is_integer(input) and input < 1 -> {:error, "number less than 1 is not acceptable"}
       is_integer(input) -> {:ok, input}
       true -> {:error, "not an integer"}
     end
   end

  def division_check(number) do
    division_check(number, 0, [])
  end

  def division_check(1, _index, factor) do
    List.to_tuple(factor)
  end

  def division_check(number, index, factor) do
    divident = elem(prime_numbers(), index)
    square_root = :math.sqrt(number)
    if divident > square_root do
      division_check(1, 0, [number | factor])
    else
      case rem(number,divident) do
        0 -> division_check(div(number,divident), 0, [divident | factor] )
        _ -> division_check(number, index+1, factor)
      end
    end
  end

end
