searchNodes=[{"doc":"An Elixir library that converts keys in maps between snake_case and camel_case","ref":"ProperCase.html","title":"ProperCase","type":"module"},{"doc":"Converts an atom to a camelCase string","ref":"ProperCase.html#camel_case/1","title":"ProperCase.camel_case/1","type":"function"},{"doc":"Converts a string to camelCase","ref":"ProperCase.html#camel_case/2","title":"ProperCase.camel_case/2","type":"function"},{"doc":"Converts a string to snake_case","ref":"ProperCase.html#snake_case/1","title":"ProperCase.snake_case/1","type":"function"},{"doc":"Converts all the keys in a map to camelCase if mode is :lower or CamleCase if mode is :upper. If the map is a struct with no Enumerable implementation, the struct is considered to be a single value.","ref":"ProperCase.html#to_camel_case/1","title":"ProperCase.to_camel_case/1","type":"function"},{"doc":"","ref":"ProperCase.html#to_camel_case/2","title":"ProperCase.to_camel_case/2","type":"function"},{"doc":"Converts all the keys in a map to snake_case. If the map is a struct with no Enumerable implementation, the struct is considered to be a single value.","ref":"ProperCase.html#to_snake_case/1","title":"ProperCase.to_snake_case/1","type":"function"},{"doc":"module that exposes a version of encode_to_iodata!/1 that transforms data before encoding to json. This is designed to work with phoenix. Options: transform - artity 1 function that is executed before passing the result to json_encoder.encode_to_iodata! json_encoder - JSON encoder that implements encode_to_iodata!. Default: Jason usage:def MyApp.CustomJSONEncoder do use ProperCase.JSONEncoder, transform: &amp;ProperCase.to_camel_case/1 end config.exs :phoenix, :format_encoders, json: MyApp.CustomJSONEncoder","ref":"ProperCase.JSONEncoder.html","title":"ProperCase.JSONEncoder","type":"module"},{"doc":"","ref":"ProperCase.JSONEncoder.CamelCase.html","title":"ProperCase.JSONEncoder.CamelCase","type":"module"},{"doc":"","ref":"ProperCase.JSONEncoder.CamelCase.html#encode_to_iodata!/1","title":"ProperCase.JSONEncoder.CamelCase.encode_to_iodata!/1","type":"function"},{"doc":"A helpful plug that converts your incoming parameters to Elixir's snake_casePlug it into your router.ex connection pipeline like so: pipeline :api do plug :accepts, [&quot;json&quot;] plug ProperCase.Plug.SnakeCaseParams end","ref":"ProperCase.Plug.SnakeCaseParams.html","title":"ProperCase.Plug.SnakeCaseParams","type":"module"},{"doc":"","ref":"ProperCase.Plug.SnakeCaseParams.html#call/2","title":"ProperCase.Plug.SnakeCaseParams.call/2","type":"function"},{"doc":"","ref":"ProperCase.Plug.SnakeCaseParams.html#init/1","title":"ProperCase.Plug.SnakeCaseParams.init/1","type":"function"}]