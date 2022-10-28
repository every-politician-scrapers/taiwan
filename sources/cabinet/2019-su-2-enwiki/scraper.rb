#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Members
    decorator RemoveReferences
    decorator UnspanAllTables
    decorator WikidataIdsDecorator::Links

    def member_container
      noko.xpath("//table[.//th[contains(.,'English')]][position()<3]//tr[td]")
    end
  end

  class Member
    field :id do
      name_node.css('a/@wikidata').first
    end

    field :name do
      name_node.at_css('a') ? name_node.at_css('a').text.tidy : name_node.text.tidy
    end

    field :positionID do
    end

    field :position do
      tds[0].text.split('(').first.tidy
    end

    field :startDate do
    end

    field :endDate do
    end

    private

    def tds
      noko.css('th,td')
    end

    def name_node
      tds[-2]
    end

    def raw_start
    end

    def raw_end
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url).csv
