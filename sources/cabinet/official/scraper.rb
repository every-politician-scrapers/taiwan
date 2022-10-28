#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      noko.css('.title span').text.tidy
    end

    field :position do
      noko.css('.title').xpath('text()').text
    end
  end

  class Members
    def member_container
      noko.css('.member_box')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
