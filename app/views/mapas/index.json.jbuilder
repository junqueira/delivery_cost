json.array!(@mapas) do |mapa|
  json.extract! mapa, :id, :nome
  json.url mapa_url(mapa, format: :json)
end
