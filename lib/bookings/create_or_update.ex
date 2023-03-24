defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        complete_date: date,
        local_origin: origin,
        local_destination: destination,
        user_id: user_id
      }) do
    {:ok, booking} = Booking.build(date, origin, destination, user_id)

    BookingAgent.save(booking)
  end
end
