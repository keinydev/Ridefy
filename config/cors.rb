configure do
  enable :cross_origin

  set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
end

before do
  response.headers["Access-Control-Allow-Origin"] = '*'
end

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
end
