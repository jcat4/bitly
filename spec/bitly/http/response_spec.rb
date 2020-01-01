# frozen_string_literal: true

RSpec.describe Bitly::HTTP::Response do
  it "is initialized with a status code, body and headers" do
    response = Bitly::HTTP::Response.new(status: "200", body: "{}", headers: {})
    expect(response.status).to eq("200")
    expect(response.body).to eq({})
    expect(response.headers).to eq({})
  end

  it "can be initialized with a status code, body, headers and request" do
    request = Bitly::HTTP::Request.new(uri: URI.parse("http://example.com"))
    response = Bitly::HTTP::Response.new(status: "200", body: "{}", headers: {})
    expect(response.status).to eq("200")
    expect(response.body).to eq({})
    expect(response.headers).to eq({})
  end

  it "expects a valid HTTP status" do
    expect {
      Bitly::HTTP::Response.new(status: "hello", body: "{}", headers: {})
    }.to raise_error(ArgumentError)
  end

  it "expects a valid JSON body" do
    expect {
      Bitly::HTTP::Response.new(status: "200", body: "blah", headers: {})
    }.to raise_error(ArgumentError)
  end

  it "expects headers to be a hash" do
    expect {
      Bitly::HTTP::Response.new(status: "200", body: "{}", headers: [])
    }.to raise_error(ArgumentError)
  end

  it "expects a request to be a Bitly::HTTP::Request" do
    expect {
      Bitly::HTTP::Response.new(status: "200", body: "{}", headers: {}, request: "What?")
    }.to raise_error(ArgumentError)
  end
end
