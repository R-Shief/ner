class Entity < ActiveRecord::Base
  belongs_to :entity_category
  belongs_to :page

  validates :name, presence: true
  validates :page, presence: true, uniqueness: true

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do 
    indexes :id, type: "integer"
    indexes :name, boost: 30
    # indexes :clear_name
    # indexes :brief
  end 

  def clear_name
    name.gsub(/\(.*\)/,'').gsub('_',' ')
  end


  def self.search(params={})
    current_query = nil
    current_query = params  if params.is_a?(String) 
    current_query = params[:query] if params.is_a?(Hash) && params[:query].present?
    raise "Invalid query parameter value, expecting a string or hash with :query"  if current_query.nil?
    tire.search(load: true, page: 1, per_page: 50) do 
      query {string current_query, default_operator: "OR"} 
    end

  end  
end
