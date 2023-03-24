defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    case User.build(name, email, cpf) do
      {:ok, user} -> save_user(user)
      {:error, reason} -> {:error, reason}
    end
  end

  defp save_user(%User{} = user) do
    UserAgent.save(user)

    {:ok, "Operation succeed"}
  end

  defp save_user({:error, message}), do: {:error, message}
end
