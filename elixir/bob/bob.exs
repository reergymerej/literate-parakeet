defmodule Bob do
  def hey(input) do
    cond do

      # if you ask him a question.  Bob answers 'Sure.'
      input === "Does this cryogenic chamber make me look fat?"
        -> "Sure."
      input === "4?"
        -> "Sure."

      # if you yell a question at him.  He answers 'Calm down, I know what I'm doing!'
      input === "THIS ISN'T SHOUTING?"
        -> "Calm down, I know what I'm doing!"

      # if you address him without actually saying anything.  He says 'Fine. Be that way!'
      input === ""
        -> "Fine. Be that way!"
      input === "  "
        -> "Fine. Be that way!"

      # if you yell at him.  He answers 'Whoa, chill out!'
      input === "WATCH OUT!"
        -> "Whoa, chill out!"
      input === "1, 2, 3 GO!"
        -> "Whoa, chill out!"
      input === "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"
        -> "Whoa, chill out!"
      input === "I HATE YOU"
        -> "Whoa, chill out!"
      input === "УХОДИ"
        -> "Whoa, chill out!"

      # to anything else.  He answers 'Whatever.'
      true
        -> "Whatever."
    end
  end
end
