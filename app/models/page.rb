class Page < ActiveRecord::Base

  def self.table_name
    "page"
  end

  scope :has_html_eq, lambda { |has| has == "yes" ? has_html : has_no_html }
  # search_method :has_html_eq
  scope :imported_eq,  lambda{ |ans|
                            if(ans)
                                where("html is not null")
                            elsif (ans== false)
                                where(html: nil)
                            end
                            }


  scope :has_html, where("html is not null")
  scope :has_no_html, where(html: nil)

  def self.fill_all_html
    counts={done: 0, 
            failed: 0
          }
    step=500
    content=nil
    p=nil
    self.select([:page_id, :page_title]).where(html: nil).find_each(:batch_size=>1000) do |p|
      begin
        content = ContentGrabberHelper.get_content(p.page_title)
        p.update_attributes(html:  content, importing_status: importing_statuses[:importred] )
        counts[:done] +=1
        print "." if (counts[:done] % step).zero?
      rescue=>e 
        counts[:failed]+=1
        print "." if (counts[:failed] % step).zero?
        if e.is_a?(ActiveRecord::StatementInvalid)
          dir=FileUtils.mkdir_p("#{Rails.root}/data/skipped").first
          File.open("#{dir}/#{p.page_id}.html","w"){|o| o.puts content}
          p.update_attributes(html: nil, importing_status: importing_statuses[:too_long])
        elsif e.is_a?(OpenURI::HTTPError)
          p.update_attributes(html: nil, importing_status: importing_statuses[:failed_404])
        else
          Rails.logger.error "[IMPORTING ERROR] #{e.class.name}\n #{e.to_s}"
        end
      end
    end
    counts   
  rescue => e   
    return [e, p.page_id]
  end

  def self.importing_statuses
    {
      pending: 0,
      importred: 1,
      too_long: 2,
      failed_404: 3
    }
  end

  def clear_name
    page_title.force_encoding('utf-8').gsub(/\(.*\)/,'').gsub('_',' ')
  end

  def first_p
    return nil if self.html.nil?
    doc = Nokogiri::HTML(self.html)
    doc.search("p").first.text
  rescue
    puts "failed to get p for page: #{self.id}"
    return nil
  end

  def generate_entity
    brief = self.first_p
    retrun nil if brief.nil?

    Entity.create(name: self.clear_name, brief: brief, page: self)
  end


end
