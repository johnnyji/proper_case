defmodule ProperCase.Plug.SnakeCaseParamsTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ProperCase.Plug.SnakeCaseParams

  test "snake cases incoming params" do
    params = %{
      "firstParam" => "first",
      "SecondParam" => "second",
      "nestedParam" => %{
        "innerParam" => "inner"
      }
    }

    conn =
      :get
      |> conn("/test", params)
      |> receive_request
      |> SnakeCaseParams.call([])

    assert conn.params == %{
             "first_param" => "first",
             "second_param" => "second",
             "nested_param" => %{
               "inner_param" => "inner"
             }
           }
  end

  defp receive_request(conn) do
    conn
    |> Plug.Parsers.call(
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Jason
    )
  end
end
