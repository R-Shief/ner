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

    self.select([:page_id, :page_title]).where(html: nil).find_each(:batch_size=>1000) do |p|
      begin
        p.update_attributes(html: ContentGrabberHelper.get_content(p.page_title))
        counts[:done] +=1
        print "." if (counts[:done] % step).zero?
      rescue=>e 
        counts[:failed]+=1
        print "." if (counts[:failed] % step).zero?
      end
    end
    counts   
  end

end
