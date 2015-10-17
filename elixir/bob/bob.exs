defmodule Teenager do
  def hey(input) do
    cond do
      Regex.match?(~r/\?$/, input)
        -> "Sure."
      String.strip(input) == ""
        -> "Fine. Be that way!"
      String.downcase(input) != input and String.upcase(input) == input
        -> "Whoa, chill out!"
      input != nil
        -> "Whatever."
      true -> raise "Your implementation goes here"
    end
  end
end
