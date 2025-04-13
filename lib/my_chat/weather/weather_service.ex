defmodule MyChat.Weather.Service do
  @behaviour MyChat.Weather.Api

  def today(location) do
    weather_key = System.get_env("WEATHER_KEY")
    encoded_location = URI.encode(location)
    weather_res = Req.get!("https://api.openweathermap.org/data/2.5/weather?q=#{encoded_location}&units=metric&appid=#{weather_key}").body
    if (weather_res["cod"] != 200) do
      {:error, weather_res["message"]}
    else
      {:ok, %MyChat.Weather{
        id: Ecto.UUID.generate(),
        temperature: weather_res["main"]["temp"],
        units: :celsius,
        precipitation:  get_precipitation(weather_res),
        location: location
      }
      }
    end
  end

  defp get_precipitation(weather_json) do
    cond do
      Map.has_key?(weather_json, "rain") ->
        %{type: :rain, chance: weather_json["rain"]["1h"] || 0}
      Map.has_key?(weather_json, "snow") ->
        %{type: :snow, chance: weather_json["snow"]["1h"] || 0}
      Map.has_key?(weather_json, "sleet") ->
        %{type: :clouds, chance: weather_json["sleet"]["all"] || 0}
      Map.has_key?(weather_json, "hail") ->
        %{type: :hail, chance: weather_json["hail"]["all"] || 0}
      true ->
        nil
    end
  end
end
