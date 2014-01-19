require 'spec_helper'

describe Piece do
  describe '#full_details_hash' do
    let('results') do
      {"title"=>"The Peaceable Kingdom", "uri"=>"http://www.brooklynmuseum.org/opencollection/objects/610/The_Peaceable_Kingdom", "accession_number"=>"40.340", "classification"=>"Painting", "comments"=>[], "image"=>"http://cdn2.brooklynmuseum.org/images/opencollection/objects/size2/40.340_SL1.jpg"}
    end
    let(:api_json_rsponse) do
      "{\n  \"response\": {\n    \"resultset\": {\n      \"total\": 1,\n      \"start_index\": 0,\n      \"results_limit\": 20,\n      \"query\": \"keyword=40.340\",\n      \"items\": [\n        {\n          \"type\": \"object\",\n          \"id\": \"610\",\n          \"title\": \"The Peaceable Kingdom\",\n          \"uri\": \"http:\\/\\/www.brooklynmuseum.org\\/opencollection\\/objects\\/610\\/The_Peaceable_Kingdom\",\n          \"images\": {\n            \"total\": \"3\",\n            \"results_limit\": 1,\n            \"0\": {\n              \"uri\": \"http:\\/\\/cdn2.brooklynmuseum.org\\/images\\/opencollection\\/objects\\/size2\\/40.340_SL1.jpg\",\n              \"thumb_uri\": \"http:\\/\\/cdn2.brooklynmuseum.org\\/images\\/opencollection\\/objects\\/size0\\/40.340_SL1.jpg\",\n              \"credit\": \"Brooklyn Museum photograph\",\n              \"description\": null,\n              \"is_color\": true,\n              \"rank\": 0\n            }\n          },\n          \"accession_number\": \"40.340\",\n          \"object_date\": \"ca. 1833-1834\",\n          \"object_date_begin\": \"1830\",\n          \"object_date_end\": \"1840\",\n          \"medium\": \"Oil on canvas\",\n          \"dimensions\": \"17 7\\/16 x 23 9\\/16 in. (44.3 x 59.8 cm)\",\n          \"signed\": \"Unsigned\",\n          \"credit_line\": \"Dick S. Ramsay Fund\",\n          \"classification\": \"Painting\",\n          \"label\": \"From about 1820, the self-taught artist and Quaker preacher Edward Hicks painted approximately sixty versions of <i>The Peaceable Kingdom<\\/i> in an effort to reconcile his artistic vocation with his ardent faith. The subject is based on verses from the Old Testament Book of Isaiah that describe an Edenic world in which predatory animals (a leopard, lion, and bear) coexist in harmony with meeker creatures (a lamb, kid, and calf) and children. In the background, the earthly realization of this prophecy is represented by a historical scene of William Penn forging a treaty with Native Americans, based on Benjamin West\\\\'s famous painting. With these themes of peace, Hicks could have also been expressing his hope for reconciliation within the Society of Friends after a recent theological split. His linear, flat style both recalls Hicks\\\\'s training as a sign painter and allays Quaker suspicions about the sensual pleasures of art.<br \\/>\",\n          \"artists\": [\n            {\n              \"uri\": \"http:\\/\\/www.brooklynmuseum.org\\/opencollection\\/artists\\/2334\\/Edward_Hicks\",\n              \"id\": \"2334\",\n              \"name\": \"Edward Hicks\",\n              \"dates\": \"American, 1780-1849\",\n              \"nationality\": \"American\",\n              \"role\": \"Artist\",\n              \"type\": \"artist\"\n            }\n          ],\n          \"location\": \"American Identities: A New Look, Making Art: Centennial Era, 5th Floor\",\n          \"collection\": \"American Art\",\n          \"rightstype\": \"no_known_copyright_restrictions\",\n          \"rank\": 0\n        }\n      ]\n    },\n    \"status\": \"success\"\n  }\n}"
    end

    before do
      stub_request(:get, "http://www.brooklynmuseum.org/opencollection/api/?api_key=&format=json&item_type=object&keyword=40.340&method=collection.search&version=1").
           with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
           to_return(:status => 200, :body => api_json_rsponse, :headers => {})
    end

    it 'returns the details from the api' do
      piece = Piece.new(accession_number: '40.340')
      expect(piece.full_details_hash).to eq(results)
    end
  end
end
