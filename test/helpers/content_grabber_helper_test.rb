 # -*- coding: utf-8 -*-
require 'test_helper'

class ContentGrabberHelperTest < ActionView::TestCase

  def test_grabbing_content
    page_title="القلعة_(رواية)"    
    html=ContentGrabberHelper.get_content(page_title)
    assert html.index('القلعة السلطة التي تحكم قرية يرغب في أن يعمل بها مساح أراض')
  end


end
