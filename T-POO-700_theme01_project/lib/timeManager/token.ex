defmodule TimeManager.Token do
  use Joken.Config

  def decode(jwt_string, public_key) do
    jwt_string
    |> Joken.token
    |> Joken.with_validation("exp", &(&1 > Joken.current_time()))
  end

end
