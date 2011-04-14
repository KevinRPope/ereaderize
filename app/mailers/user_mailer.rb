class UserMailer < ActionMailer::Base
  default :from => "pope.kevin@gmail.com"
  
  def article(user_ereader_email, doc_to_send, doc_title)
    #@doc = doc_to_send
    attachments[doc_title] = doc_to_send.to_s.html_safe

    doc_to_send.css('img').each do |node|
      new_tag = node.attribute('src').value.split("/").last
      attachments[new_tag] = node.attribute('src').value
      node.attribute('src').value = new_tag
    end
    
    mail(:to => user_ereader_email, :subject => "Your eReaderize Article")
  end
end