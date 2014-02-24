require 'mandrill'

class InvitationMailer
  def self.send_invitation_email(guest)
    template_name = "Invitation"
    subject = "Kate and Arjan's Wedding - Please RSVP"
    merge_vars = [{"rcpt"=> guest.email,
                "vars"=>[{"name"=>"token", "content"=> guest.token }]}]
    send_template_email(template_name, subject, guest, merge_vars, [])
  end   

  def self.send_confirmation_email(guest)
    template_name = "rsvpconfirmation"
    subject = "RSVP Confirmation"
    template_content = [
        {"name"=>"final_message", "content"=> build_final_message(guest) },
        {"name"=>"rsvp_info", "content"=> build_rsvp_info(guest) }]
    merge_vars = [{"rcpt"=> guest.email,
                "vars"=>[ {"name"=>"token", "content"=> guest.token },
                          {"name"=>"name", "content"=> guest.first_name }]}]
    send_template_email(template_name, subject, guest, merge_vars, template_content)
  end 

  private

  def self.build_final_message(guest)
    if guest.saturday_rsvp == Guest::RSVP_YES
        "We're looking forward to celebrating with you!"
    elsif guest.saturday_rsvp == Guest::RSVP_MAYBE
        "We hope you'll be able to join us! Just be sure to let us know your final answer by June 15."
    elsif guest.saturday_rsvp == Guest::RSVP_NO
        "We'll miss having you there!"
    end
  end

  def self.build_rsvp_info(guest)
    response = '<table style="text-align:center"><thead><tr><th></th><th style="width:125px">Friday Night Dinner</th><th style="width:120px">Wedding and Reception</th></tr></thead>'
    guest.rsvp_info.each do |group_member|
        response += "<tr><td style='padding-right:10px'>#{group_member.first_name}</td>"
        response += "<td>#{group_member.friday_rsvp_text}</td>"
        response += "<td>#{group_member.saturday_rsvp_text}</td></tr>"
    end
    response += '</table>'
    response
  end

  def self.send_template_email(template_name, subject, guest, merge_vars, template_content)
    begin
        mandrill = Mandrill::API.new ENV['MANDRILL_PASSWORD']
        template_name = template_name
        template_content = template_content
        message = {
         "subject"=> subject,
         "from_email"=>"kate.and.arjan@gmail.com",
         "from_name"=>"Kate Odell and Arjan Dehar",
         "to"=>
            [{"email"=> guest.email,
                "name"=> "#{guest.first_name} #{guest.last_name}",
                "type"=>"to"}],
         "headers"=>{"Reply-To"=>"kate.and.arjan@gmail.com"},
         "track_opens"=>true,
         "track_clicks"=>true,
         "inline_css"=>nil,
         "url_strip_qs"=>nil,
         "preserve_recipients"=>nil,
         "view_content_link"=>nil,
         "bcc_address"=>"kate.and.arjan@gmail.com",
         "tracking_domain"=>nil,
         "signing_domain"=>nil,
         "return_path_domain"=>nil,
         "merge"=>true,
         "merge_vars"=> merge_vars
        }
        async = true
        result = mandrill.messages.send_template template_name, template_content, message, async
    rescue Mandrill::Error => e
        # Mandrill errors are thrown as exceptions
        puts "A mandrill error occurred: #{e.class} - #{e.message}"
        raise
    end
  end

end