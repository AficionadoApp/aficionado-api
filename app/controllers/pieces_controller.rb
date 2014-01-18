class PiecesController < ApplicationController

  def index
    museum_json = brooklyn_museum_results(params[:accession_number])

    user_posts = Post.where(accession_number: params[:accession_number]).map(&:to_json)

    hash = museum_json.slice('title', 'uri', 'accession_number')
    hash['comments'] = user_posts
    hash['image'] = thumbnail_url(museum_json)

    render json: hash
  end

private

  def brooklyn_museum_results(accession_number)
    base_url = 'http://www.brooklynmuseum.org/opencollection/api/'
    result = RestClient.get( base_url, { params: default_params.merge({ method: 'collection.search', keyword: accession_number }) })
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
