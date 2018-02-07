# frozen_string_literal: true

# stubbed Bitly module
module MockBitly
  def self.client
    MockBitly::Client.new
  end

  # mock client class
  class Client
    Url = Struct.new(:short_url, :long_url)

    def shorten(link)
      Url.new('short.url', link)
    end

    def expand(link)
      Url.new(link, 'http://long.url')
    end
  end
end
