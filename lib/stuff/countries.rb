require 'json'
require_relative 'static_methods'

module Stuff
  class Countries
    include StaticMethods

    attr_reader :countries

    Country = Struct.new(:country_code, :name, :emoji_flag)

    def initialize
      @countries = JSON.parse(File.open(__dir__ + '/countries/countries.json', 'r:UTF-8', &:read)).map{ |c| Country.new(c.to_a[0], c.to_a[1]['name'], c.to_a[1]['emoji_flag']) }
      @cis = JSON.parse(File.open(__dir__ + '/countries/cis.json', &:read))
    end

    # @example
    #   Countries.find_by_emoji_flag("🇷🇺")
    #   # => { name: 'Russia', country_code: 'ru', emoji_flag: '🇷🇺' }
    #
    def find_by_emoji_flag(flag)
      @countries.find{ |c| c.emoji_flag == flag }
    end

    # @example
    #   Countries.find_by_code('ru')
    #   # => { name: 'Russia', country_code: 'ru', emoji_flag: '🇷🇺' }
    #
    def find_by_code(code)
      @countries.find{ |c| c.country_code == code }
    end

    # @example
    #   Countries.find_by_name('Russia')
    #   # => { name: 'Russia', country_code: 'ru', emoji_flag: '🇷🇺' }
    #
    def find_by_name(name)
      @countries.find{ |c| c.name == name }
    end

    # Check whether the country is in CIS
    # Read more @ https://en.wikipedia.org/wiki/Commonwealth_of_Independent_States
    #
    # @example
    #   Countries.is_in_cis?('ru')
    #   # => true
    #
    def is_in_cis?(obj)
      @cis['countries'].include?(obj.is_a?(String) ? obj : obj.country_code)
    end

    # Return all countries which are in CIS
    # Read more @ https://en.wikipedia.org/wiki/Commonwealth_of_Independent_States
    #
    # @example
    #   Countries.get_cis
    #   # => [<Country code="am">, <Country code="az">, ...]
    #
    def get_cis
      @cis['countries'].map{ |c| find_by_code(c) }
    end
  end
end
