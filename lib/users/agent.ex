defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(%{}) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(user) when is_struct(user, User) do
    Agent.update(__MODULE__, &Map.put(&1, user.cpf, user))
  end

  def save(_user), do: {:error, "Invalid user"}

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp get_user(user_map, key) do
    case user_map[key] do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
