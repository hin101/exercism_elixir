defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  defp _wink(x) do
    case x do
      0 -> []
      1 -> ["wink"]
    end
  end

  defp _double_blink(x) do
    case x do
      0 -> []
      1 -> ["double blink"]
    end
  end

  defp _close(x) do
    case x do
      0 -> []
      1 -> ["close your eyes"]
    end
  end

  defp _jump(x) do
    case x do
      0 -> []
      1 -> ["jump"]
    end
  end

  defp _get_handshake(seq) do
    case seq do
      [a] -> _wink(a)
      [b,a] -> _wink(a) ++ _double_blink(b)
      [c,b,a] -> _wink(a) ++ _double_blink(b) ++ _close(c)
      [d,c,b,a] -> _wink(a) ++ _double_blink(b) ++ _close(c) ++ _jump(d)
      [1,d,c,b,a] -> _jump(d) ++ _close(c) ++ _double_blink(b) ++ _wink(a)
      [1,0,0,0,0,0] -> []
    end
  end

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.digits(2)
    |> _get_handshake()
  end
end
