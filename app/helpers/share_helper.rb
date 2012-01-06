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
    google_js + facebook_js
  end
  
  # Buttons
  def facebook_share 
    content_tag(:div, nil, :class => 'fb-like', :"data-send" => false, :"data-layout" => "button_count", :"data-width" => "90", :"data-show-faces" => false)
  end
  
  def google_share
    content_tag(:div, nil, :class => 'g-plusone', :"data-size" => "medium")
  end
  
  def twitter_share
    out = link_to(t(:tweet), "https://twitter.com/share", :class => "twitter-share-button", :"data-text" => "Check out this site", :"data-related" => "amnesty")
    out << javascript_tag("!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=\"//platform.twitter.com/widgets.js\";fjs.parentNode.insertBefore(js,fjs);}}(document,\"script\",\"twitter-wjs\");")
  end

end