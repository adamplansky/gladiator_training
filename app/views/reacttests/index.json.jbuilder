json.array!(@reacttests) do |reacttest|
  json.extract! reacttest, :id
  json.url reacttest_url(reacttest, format: :json)
end
