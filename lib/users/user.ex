defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf) when not is_number(cpf) do
    user_id = UUID.uuid4()

    user = %__MODULE__{
      name: name,
      email: email,
      cpf: cpf,
      id: user_id
    }

    {:ok, user}
  end

  def build(_name, _email, _cpf), do: {:error, "Cpf must be a String"}
end
