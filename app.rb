require "sinatra"
require "sinatra/reloader"
require "openai"
require "dotenv/load"

get("/") do
  erb(:home)
end

get("/translation") do
  @input_trans = params.fetch("input")

  erb(:translation)
end
