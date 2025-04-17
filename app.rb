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

# OpenAI Resource 
client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a special English-to-Japanese translation tool. Your purpose is to translate a given body of English text into Japanese, then translate the Japanese phrase into its literal word-for-word English meaning. Keep the Japanese grammar structure while translating each word into its literal English counterpart. The objective is to restructure an English phrase into Japanese grammar using their literal Japanese meanings. Do not rephrase the meaning of the words or reorder their placement within the sentence to create a more natural English-sounding phrase. Do not reply with any additional comments or information beyond the literal translation."
  },
]

case @input_trans 
when "" then "Nothing"
else
  message_list << { "role" => "user", "content" => @input_trans }
  api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

  #api_response
  @output_trans = api_response.fetch("choices").at(0).fetch("message").fetch("content")
end
