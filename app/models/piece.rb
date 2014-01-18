class Piece < ActiveRecord::Base
  has_many :posts
  BASE_URL = 'http://www.brooklynmuseum.org/opencollection/api/'

  def full_details_hash
    museum_json = brooklyn_museum_results(self.accession_number)

    hash = museum_json.slice('title', 'uri', 'accession_number')
    hash['comments'] = posts.map(&:to_json)
    hash['image'] = thumbnail_url(museum_json)
    hash
  end

  private

  def brooklyn_museum_results(accession_number)
    result = RestClient.get( BASE_URL, { params: default_params.merge({ method: 'collection.search', keyword: accession_number }) })
    JSON.parse(result)["response"]["resultset"]["items"].first
  end

  def default_params
    {
      api_key: ENV['API_TOKEN'],
      version: 1,
      item_type: 'object',
      format: 'json'
    }
  end

  def thumbnail_url(full_hash)
    full_hash.fetch('images', {}).fetch('0', {})['uri']
  end
end
