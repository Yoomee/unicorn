module ShareHelper
  
  # Supporting javascripts
  def facebook_js
    language = I18n.locale == :es ? "es_ES" : "en_GB"
    fb_js = <<-JAVASCRIPT
    (function(d, s, id) {
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) return;
          js = d.createElement(s); js.id = id;
          js.src = "//connect.facebook.net/#{language}/all.js#xfbml=1";
          fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    JAVASCRIPT
    javascript_tag(fb_js)
  end
  
  def google_js
    g_js = <<-JAVASCRIPT
      window.___gcfg = {lang: '#{(I18n.locale == :es ? 'es' : 'en-GB')}'};
      (function() {
        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
        po.src = 'https://apis.google.com/js/plusone.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
      })();
    JAVASCRIPT
    javascript_tag(g_js)
  end
  
  def sharing_js
    google_js #+ facebook_js  Using image only
  end
  
  # Buttons
  def facebook_share 
    #content_tag(:div, nil, :class => 'fb-like', :"data-send" => false, :"data-layout" => "button_count", :"data-width" => "90", :"data-show-faces" => false)
    link_to(image_tag('fb_share.png'), "http://www.facebook.com/sharer.php?u=#{t(:site_url)}", :onclick => "window.open(this.href, 'name', 'toolbar=0,status=0,menubar=0,height=400,width=600,top=' + ((screen.height/2)-200) + ',left=' + ((screen.width/2)-300));return false;", :class => 'fb-like')
  end
  
  def google_share
    content_tag(:div, nil, :class => 'g-plusone', :"data-size" => "medium")
  end
  
  def twitter_share(text)
    out = link_to(t(:tweet), "https://twitter.com/share", :class => "twitter-share-button", :"data-text" => text, :"data-related" => t(:amnesty_twitter))
    out << javascript_tag("!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=\"//platform.twitter.com/widgets.js\";fjs.parentNode.insertBefore(js,fjs);}}(document,\"script\",\"twitter-wjs\");")
  end

end