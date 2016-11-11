defmodule ProperCase.Plug.TransformParams do
  @moduledoc """
    Transforms incoming params and outgoing response

    Options
      params: Function that transforms incoming params
      response: Function that transforms the response based on content-type

      Example:

      plug TransformParams,
        params: &ProperCase.to_snake_case/1,
        response: [
          json: &ProperCase.to_camel_case/1,
          plain_text: &String.upcase/1,
        ]
  """

  import Plug.Conn

  def init(options), do: Enum.into(options, %{})

  def call(conn, options) do
    conn
    |> Plug.Conn.register_before_send(&transform_response(&1, options))
    |> transform_params(options)
  end

  defp transform_params(conn, %{params: params_transform_fn}) do
    conn
    |> Map.update!(:params, params_transform_fn)
  end
  defp transform_params(conn, _options), do: conn

  defp transform_response(conn, %{response: response_transforms}) do
    response_transform_fn = case response_type(conn) do
      :json -> &transform_json_response(&1, response_transforms[:json])
      :plain_text -> response_transforms[:plain_text] || &(&1)
      _ -> &(&1)
    end

    conn
    |> Map.update!(:resp_body, response_transform_fn)
  end

  defp transform_response(conn, _options), do: conn

  defp transform_json_response(resp_body, json_transform_fn) when is_function(json_transform_fn) do
    resp_body
    |> String.Chars.to_string
    |> Poison.decode!
    |> json_transform_fn.()
    |> Poison.encode!
  end
  defp transform_json_response(resp_body, _), do: resp_body

  defp response_type(conn) do
    case get_resp_header(conn, "content-type") do
      ["application/json;" <> _] -> :json
      ["application/json"] -> :json
      ["text/plain;" <> _] -> :plain_text
      ["text/plain"] -> :plain_text
      other -> other
    end
  end
end

