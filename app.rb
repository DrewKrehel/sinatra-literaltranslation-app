require "sinatra"
require "sinatra/reloader"
require "better_errors"

get("/") do
  erb(:home)
end

get("/translation") do
  @trans_input = params.fetch("input")
  @num_sides = params.fetch("sides")

  erb(:translation)
end
