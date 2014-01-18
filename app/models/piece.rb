class Piece < ActiveRecord::Base
  has_many :posts
  attr_accessible :accession_number

  BASE_URL = 'http://www.brooklynmuseum.org/opencollection/api/'

  def full_details_hash
    hash = brooklyn_museum_results.slice('title', 'uri', 'accession_number', 'description', 'classification')
    hash['comments'] = posts.map(&:to_json)
    hash['image'] = thumbnail_url
    hash
  end

  private

  def brooklyn_museum_results
    @brooklyn_museum_results ||= begin
      result = RestClient.get( BASE_URL, { params: default_params.merge({ method: 'collection.search', keyword: self.accession_number }) })
      JSON.parse(result).fetch("response", {}).fetch("resultset", {}).fetch("items", []).first || {}
    end
  end

  def default_params
    {
      api_key: ENV['API_TOKEN'],
      version: 1,
      item_type: 'object',
      format: 'json'
    }
  end

  def thumbnail_url
    brooklyn_museum_results.fetch('images', {}).fetch('0', {})['uri']
  end
end
