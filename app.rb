require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "openai"
require "dotenv/load"

get("/") do
  erb(:home)
end

get("/translation") do
  @input_trans = params.fetch("input")
  @num_sides = params.fetch("sides")

  erb(:translation)
end
