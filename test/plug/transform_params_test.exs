defmodule ProperCase.Plug.TransformParamsTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias ProperCase.Plug.TransformParams

  @plug_opts TransformParams.init([
    params: &ProperCase.to_snake_case/1,
    response: [
      json: &ProperCase.to_camel_case/1,
      plain_text: &String.upcase/1,
    ]
  ])

  test "converts incoming params" do
    params = %{
      "firstParam" => "first",
      "SecondParam" => "second",
      "nestedParam" => %{
        "innerParam" => "inner",
      }
    }

    conn =
      :get
      |> conn("/test", params)
      |> receive_request
      |> TransformParams.call(@plug_opts)

    assert conn.params == %{
      "first_param" => "first",
      "second_param" => "second",
      "nested_param" => %{
        "inner_param" => "inner",
      }
    }
  end

  test "converts json response" do
    snake_case_response = %{
      "first_param" => "first",
      nested_param: %{
        inner_param: "inner",
      },
    }

    sent_response =
      :get
      |> conn("/test", %{})
      |> receive_request
      |> TransformParams.call(@plug_opts)
      |> send_json_response(200, snake_case_response)


    assert parse_json_response(sent_response, 200) == %{
      "firstParam" => "first",
      "nestedParam" => %{
        "innerParam" => "inner"
      },
    }
  end

  test "converts plain text response" do
    response =
      :get
      |> conn("/test", %{})
      |> receive_request
      |> TransformParams.call(@plug_opts)
      |> send_plain_text_response(200, "plain text")

    assert response.resp_body == "PLAIN TEXT"
  end

  test "ignores undefined responses" do
    response =
      :get
      |> conn("/test", %{})
      |> receive_request
      |> TransformParams.call(%{})
      |> send_plain_text_response(200, "plain text")

    assert response.resp_body == "plain text"
  end

  test "ignores unsupported content-types" do
    response =
      :get
      |> conn("/test", %{})
      |> receive_request
      |> TransformParams.call(@plug_opts)
      |> put_resp_header("content-type", "application/pdf;")
      |> Plug.Conn.send_resp(200, "pdf content")

    assert response.resp_body == "pdf content"
  end

  defp receive_request(conn) do
    conn
    |> Plug.Parsers.call(
       parsers: [:urlencoded, :multipart, :json],
       pass: ["*/*"],
       json_decoder: Poison
     )
  end


  defp parse_json_response(conn, status) do
    assert conn.status == status

    Poison.decode!(conn.resp_body)
  end

  defp send_json_response(conn, status, json) do
    formatted_body = json |> Poison.encode! |> String.to_charlist
    conn
    |> put_resp_header("content-type", "application/json;")
    |> Plug.Conn.send_resp(status, formatted_body)
  end

  defp send_plain_text_response(conn, status, body) do
    conn
    |> put_resp_header("content-type", "text/plain; charset=utf-8")
    |> Plug.Conn.send_resp(status, body)
  end
end
