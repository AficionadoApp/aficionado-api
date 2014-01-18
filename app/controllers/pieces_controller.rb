class PiecesController < ApplicationController

  def index
    # params[:accession_number] = "234232.23423"

    museum_json = brooklyn_museum_results(params[:accession_number])

    user_posts = Post.where(accession_number: params[:accession_number]).map(&:to_json)

    hash = museum_json.slice('title', 'uri')
    hash['comments'] = user_posts

    render json: hash
  end

end

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


# Brian
# base url http://www.brooklynmuseum.org/opencollection/api/
# 3:36 PM

# Brian
# method=collection.search
# api_key={api_key}
# version=1
# keyworkd={accession_id}

# ---------- Forwarded message ----------
# From: <api@brooklynmuseum.org>
# Date: Sat, Jan 18, 2014 at 2:55 PM
# Subject: Brooklyn Museum API Key
# To: brooklynmuseum.org@brian.iheardata.com


# API Key: 30lqBzIB1O



# Documentation:
# http://www.brooklynmuseum.org/opencollection/api

# News & RSS Feed:
# http://www.brooklynmuseum.org/opencollection/api/docs/news

# Application Gallery:
# http://www.brooklynmuseum.org/opencollection/api/docs/application_gallery