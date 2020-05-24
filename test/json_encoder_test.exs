defmodule ProperCase.JSONEncoderTest do
  use ExUnit.Case, async: true

  defmodule TestEncoder do
    use ProperCase.JSONEncoder, transform: fn data -> %{transformed: data} end
  end

  test "transforms before encoding" do
    data = %{
      user: %{
        first_name: "Han",
        last_name: "Solo",
        allies_in_combat: [
          %{name: "Luke", weapon_of_choice: "lightsaber"},
          %{name: "Chewie", weapon_of_choice: "bowcaster"},
          %{name: "Leia", weapon_of_choice: "blaster"}
        ]
      }
    }

    expected_data = %{
      "transformed" => %{
        "user" => %{
          "first_name" => "Han",
          "last_name" => "Solo",
          "allies_in_combat" => [
            %{"name" => "Luke", "weapon_of_choice" => "lightsaber"},
            %{"name" => "Chewie", "weapon_of_choice" => "bowcaster"},
            %{"name" => "Leia", "weapon_of_choice" => "blaster"}
          ]
        }
      }
    }

    result = TestEncoder.encode_to_iodata!(data)

    assert Jason.decode!(result) == expected_data
  end
end
