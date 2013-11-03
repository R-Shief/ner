class Page < ActiveRecord::Base
  def self.table_name
    "page"
  end


  def self.fill_all_html
    counts={done: 0, 
            failed: 0
          }
    step=1000

    self.select([:page_id, :page_title]).where(html: nil).find_each(:batch_size=>500) do |p|
      begin
        p.update_attribute(html: ContentGrabberHelper.get_content(p.page_title))
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
