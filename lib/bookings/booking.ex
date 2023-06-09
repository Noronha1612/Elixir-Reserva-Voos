defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(date, origin, destination, user_id) do
    booking_id = UUID.uuid4()

    booking = %__MODULE__{
      id: booking_id,
      complete_date: date,
      local_origin: origin,
      local_destination: destination,
      user_id: user_id
    }

    {:ok, booking}
  end
end
