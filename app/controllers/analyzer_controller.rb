class AnalyzerController < ApplicationController

  after_filter :cors_set_access_control_headers

  def analyze
    

    response = {
      "api_version"=> "0.1",
    }
    if params[:query].present?
      entities = Entity.limit(22)
      entities = Entity.extract_entities params[:query]
      response.merge!({
          "status"=>"success",
          "size"=> entities.size,
          "entities"=> entities.collect(&:to_hash)
        })
    else
      response.merge!({
        "status"=> "Error",
        "error_message"=> "Parameter 'query' is missing"
        })

    end




    respond_to do |format|
      format.html { render text: Oj.dump(response) }
      format.js { render text: Oj.dump(response) }
    end
  end


private
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://r-shief.org/'
    headers['Access-Control-Allow-Methods'] = 'POST, GET'
    headers['Access-Control-Allow-Headers'] = '*'
  end 
end
