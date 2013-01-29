class TestController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'uri'
  require 'net/http'
  
  def test_grab
    #Check for article already sent, if so just send the content in the db.  Save some time/energy.
    if session[:user_id]
      @user = User.find(session[:user_id])
      if @user.ereader_email.blank?
        flash[:error] = "You need to set your eReader's email address before you can send an article to your eReader."
        redirect_to :controller => :users, :action => :ereader_edit, :id => session[:user_id]
      else
        @doc = Nokogiri::HTML(open(params[:site_url])) do |config|
        #@doc = Nokogiri::HTML(open("http://localhost:3000/yahoo.html")) do |config|
          config.noblanks
        end
        title = @doc.css('title').inner_text.to_s.gsub(".","") + ".html"
    
        url = URI.parse(params[:site_url]).host.split(".")
        if url.length > 2
          url = url[1..10].join(".")
        else
          url = url[0..1].join(".")
        end
        
        @doc = Nokogiri::HTML(Site.strip_document(@doc, url, params[:images]).to_html)
        
        #@doc = Site.strip_document(@doc, url, params[:images])
        
        article = Article.find_by_stripped_url(params[:site_url].split("?")[0])

        if article
          article.times_sent = article.times_sent + 1
        else
          article = Article.new(:url => params[:site_url], 
            :stripped_url => params[:site_url].split("?")[0], 
            :parameters => params[:site_url].split("?")[1],
            :site_id => Site.find_by_domain(url, :select => :id),
            :content => @doc,
            :to_email => @user.ereader_email,
            :times_sent => 1
          )
        end
        article.save
  
        if true
          UserMailer.article(@user.ereader_email, @doc, title).deliver
          flash[:notice] = "Your article has been sent!"
          redirect_to test_index_path
        else
          @doc = @doc.to_html.to_s.html_safe
          render :layout => false
        end
      end
    else
      flash[:error] = "You need to create an eReaderize account before you can send an article to your eReader."
      #set session[:article_url] to the article they tried to send!
      redirect_to :controller => :admin, :action => :register
    end
  end

  def index
    #(2..10).each { |n| p n if n.isprime}

=begin   
    blah = "hello"
    what = ""
    blah.each_char {|c| what.insert(0,c)}
    p what
=end
    if session[:user_id]
      @user = User.find(session[:user_id], :select => "email, name, ereader_email, access_level")
    end
    @sites = Site.select('domain')
  end
  

end
