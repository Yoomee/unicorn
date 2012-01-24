module ApplicationHelper
  def param(name,value)
    content_tag(:param, nil, :name => name, :value => value)
  end
  
  def youtube_url
    "http://www.youtube.com/v/#{t :video_id}?enablejsapi=1&version=3&hl=en_US&autohide=1&rel=0&showinfo=0&wmode=opaque&fs=1"    
  end
end
