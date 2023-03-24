defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Bookings.Report

  describe "generate/3" do
    setup do
      Flightex.start_links()

      :ok
    end

    test "when called, return the content" do
      {:ok, user_id} = Flightex.create_or_update_user(build(:users))

      params = %{
        complete_date: ~N[2001-05-07 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: user_id,
        id: UUID.uuid4()
      }

      Flightex.create_or_update_booking(params)
      Report.generate(~N[2000-05-07 12:00:00], ~N[2002-05-07 12:00:00], "report-test.csv")
      {:ok, file} = File.read("report-test.csv")

      expected_response = "#{user_id},Brasilia,Bananeiras,2001-05-07 12:00:00\n"

      assert file =~ expected_response
    end
  end
end
