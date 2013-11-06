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


end
