defmodule HTTParrot.HeadersHandlerTest do
  use ExUnit.Case
  import :meck
  import HTTParrot.HeadersHandler

  setup do
    new :cowboy_req
    new JSEX
    on_exit fn -> unload end
    :ok
  end

  test "returns prettified json with headers list" do
    expect(:cowboy_req, :headers, 1, {:headers, :req2})
    expect(JSEX, :encode!, [{[[headers: :headers]], :json}])

    assert get_json(:req1, :state) == {:json, :req2, :state}

    assert validate :cowboy_req
    assert validate JSEX
  end
end
