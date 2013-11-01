 # -*- coding: utf-8 -*-
 
class DebugController < ApplicationController


  def show
    doc=ContentGrabberHelper.get_content("القلعة_(رواية)")
    render text: doc.to_html
  end
end
