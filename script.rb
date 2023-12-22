# frozen_string_literal: true

require 'net/http'
require 'uri/https'
require 'json'
require 'pry'

NOTION_HOST = 'api.notion.com'
PAGE_PATH = '/v1/pages'

File.readlines('.env', chomp: true).each { |line| ENV.store(*line.split('=')) }

headers = {
  'Authorization' => "Bearer #{ENV['NOTION_KEY']}",
  'Content-Type' => 'application/json',
  'Notion-Version' => '2022-06-28'
}

body = {
  parent: {
    page_id: '2aadcb4694944f19bc0dc673f6abbf4b'
  },
  properties: {
    title: {
      title: [
        {
          type: 'text',
          text: {
            content: 'A note from your pals at Notion.'
          }
        }
      ]
    }
  },
  children: [
    {
      object: 'block',
      type: 'paragraph',
      paragraph: {
        rich_text: [
          {
            type: 'text',
            text: {
              content: 'Pretty cool, huh?'
            }
          }
        ]
      }
    }
  ]
}

uri = URI::HTTPS.build(host: NOTION_HOST, path: PAGE_PATH)

puts Net::HTTP.post(uri, body.to_json, headers)
