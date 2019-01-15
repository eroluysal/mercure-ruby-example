require 'json'
require 'jwt'
require 'net/http'

payload = { mercure: { publish: [:foo] } }
token = JWT.encode payload, 'secret', 'HS256', typ: 'JWT'

Net::HTTP.start('localhost', 3314) do |http|
  req = Net::HTTP::Post.new('/hub')
  req['Authorization'] = "Bearer #{token}"
  req['Content-Type'] = 'Content-type: application/x-www-form-urlencoded'
  req.form_data = {
    topic: 'http://localhost:3000/demo/books/1.jsonld',
    data: { key: :value }.to_json
  }
  req = http.request(req)

  puts req.body
end
