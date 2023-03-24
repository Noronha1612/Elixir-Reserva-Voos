defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Agent, as: BookingAgent

  def generate(from, to, pathname \\ "report.csv") do
    booking_list = build_booking_list(from, to)

    File.write(pathname, booking_list)
  end

  defp build_booking_list(from, to) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.filter(&filter_booking_between_date(&1, from, to))
    |> Enum.map(&parse_booking_line/1)
  end

  defp filter_booking_between_date(booking, from, to) do
    booking_date = booking.complete_date

    is_after_from = NaiveDateTime.diff(booking_date, from) >= 0
    is_before_to = NaiveDateTime.diff(to, booking_date) >= 0

    is_after_from and is_before_to
  end

  defp parse_booking_line(%Booking{
         user_id: user_id,
         local_origin: origin,
         local_destination: destination,
         complete_date: date
       }) do
    "#{user_id},#{origin},#{destination},#{parse_date(date)}\n"
  end

  defp parse_date(date) do
    NaiveDateTime.to_string(date)
  end
end
