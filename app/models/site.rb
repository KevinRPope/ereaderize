require 'nokogiri'

class Site < ActiveRecord::Base
has_many :articles
  
  def self.strip_document(doc, article_domain, images=false)

    #John Mauldin

    #doc.css("link").remove
    #doc.css("head").remove
    #doc.css("script").remove
    #doc.css("style").remove
    #doc.css("noscript").remove
    
    #doc.css("form").remove
    #doc.css("a[@href]").each do |node| node.replace(node.inner_text) unless node['href'][0,1] == '#' end
    #doc.css('p').each do |node|    #Remove extra carriage returns and blank p tags
    #  node.content = node.content.gsub("\n", "")
    #  node.remove if node.inner_text == ''
    #end
    
    eval_code = Site.find_by_domain(article_domain, :select => :code)
#    eval_code = 1
    if eval_code.nil?
      builder = Nokogiri::HTML::Builder.new do |d|
        d.html {
          d.body {
            doc.root.traverse { |node| 
              if node.name == 'p'
                d.p(node.inner_text)
              elsif node.name == 'img'
                if images then d.img(:src => node.get_attribute('src')) end
              end
            }
          }
        }
      end
      builder
    else

=begin


doc.css("link").remove
doc.css("head").remove
doc.css("script").remove
doc.css("style").remove
doc.css("noscript").remove
doc.css('div[@id=header]').remove
doc.css('div[@id=footer]').remove
doc.css('div[@id=sidebar]').remove
doc.css('div[@id=articleFooter]').remove
doc.css('div[@class=articletools]').remove
doc.css('div[@id=articleTabSection]').remove
doc.css('div[@id=bannerStrip]').remove
doc.css('div[@id=blogsBannerStrip]').remove
doc.css('div[@id=breakingNewsBand]').remove
doc.css('div[@id=trackbar]').remove
doc.css('div[@id=googleAd]').remove
doc.css('div[@id=commentForm]').remove
doc.css('div[@id=recommendedArticles]').remove
doc.css('div[@class=columnRight]').remove
doc.css('div[@class=commentDisclaimer]').remove
doc.css('div[@class=articleComments]').remove
doc.css('div[@class=socialComments]').remove
doc.css('div[@class=relatedTopicButtons]').remove
doc.css('div[@class=\'column1 gridPanel grid4\']').remove
doc.css('span[@id=trackingEnabledModule]').remove
#might need to check span tags within p tags, like with the sub-header
builder = Nokogiri::HTML::Builder.new do |d|
 d.html {
  d.body {
   doc.root.traverse { |node| 
    if node.name == 'p'
     d.p(node.inner_text)
    elsif node.name == 'h1'
     d.p(node.inner_text)
    elsif node.name == 'h2'
     d.p(node.inner_text)
    elsif node.name == 'img'
     if images then d.img(:src => "http://www.reuters.com" + node.get_attribute('src')) end
    end
   }
  }
 }
end
builder
=end

      doc = eval(eval_code.code)
    end
  end
  
end
