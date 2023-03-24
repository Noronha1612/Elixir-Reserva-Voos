defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  use Agent

  def start_link(%{}) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(booking) when is_struct(booking, Booking) do
    Agent.update(__MODULE__, &Map.put(&1, booking.id, booking))

    {:ok, booking.id}
  end

  def save(_booking), do: {:error, "Invalid booking"}

  def list_all() do
    Agent.get(__MODULE__, & &1)
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp get_booking(booking_map, key) do
    case booking_map[key] do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
