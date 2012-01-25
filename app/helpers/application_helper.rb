module ApplicationHelper
  def param_tag(name,value)
    "<param name=\"#{name}\" value=\"#{value}\"></param>".html_safe
  end
  
  def youtube_url
    "http://www.youtube.com/v/#{t :video_id}?enablejsapi=1&version=3&hl=en_US&autohide=1&rel=0&showinfo=0&wmode=opaque&fs=1"    
  end
end
