class Entity < ActiveRecord::Base
  # belongs_to :entity_category
  # belongs_to :page

  validates :name, presence: true
  validates :page, presence: true, uniqueness: true

  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  index_name "ner_index" 

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

  def self.queries_logger
    @@query_logger ||= Logger.new("#{Rails.root}/log/analyzed_queries.log")
    @@query_logger
  end

  def self.extract_entities(analyzed_text)
    entities = Entity.search(analyzed_text)
    queries_logger.info "API HIT: QUERY:#{analyzed_text}\t SIZE: #{entities.size}\tTOPICS: #{entities.collect(&:name).join(', ')}"
    entities
  end




  def serializable_hash(options={})
    options ||={}  
    attrs = (options[:attrs] || []) | [:brief, :name]
    # methods = (options[:methods] || []) | ['entity_type_name']
    # options.merge!({ :only=>attrs, :methods=>methods})
    options.merge!({ :only=>attrs})
    super(options)
  end


  def to_hash
    serializable_hash
  end

  def self.to_hash
    self.collect(&:to_hash)
  end

  def to_json
    Oj.dump(serializable_hash)
  end

  def self.to_json
    Oj.dump(collect(&:to_json))
  end

end
