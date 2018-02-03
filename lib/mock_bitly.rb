# frozen_string_literal: true

# stubbed Bitly module
module MockBitly
  def self.client
    MockBitly::Client.new
  end

  # mock client class
  class Client
    Url = Struct.new(:short_url)

    def shorten(link)
      raise 'A link is required' unless link
      Url.new('short.url')
    end
  end
end
