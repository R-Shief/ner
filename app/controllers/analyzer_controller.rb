class AnalyzerController < ApplicationController
  def analyze
    

    response = {
      "api_version"=> 0.1,
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
end
