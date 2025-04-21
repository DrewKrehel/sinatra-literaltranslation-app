require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "openai"
require "dotenv/load"

get("/") do
  erb(:test_home)
end

get("/translation") do
  @input_trans = params.fetch("input")

  erb(:translation)
end
