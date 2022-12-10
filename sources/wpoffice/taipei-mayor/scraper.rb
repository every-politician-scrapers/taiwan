#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Portrait'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[no img name start end].freeze
    end

    # Some cells have two starts and two ends. We want the first start and last end
    def raw_start
      start_cell.css('text()').map(&:text).map(&:tidy).reject(&:empty?).first
    end

    def raw_end
      end_cell.css('text()').map(&:text).map(&:tidy).reject(&:empty?).last.gsub('Elect', '')
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
