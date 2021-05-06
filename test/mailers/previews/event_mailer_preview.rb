class EventMailerPreview < ActionMailer::Preview
  def comment
    EventMailer.comment(Event.last, Event.find(3).comments.last, Event.last.user.email)
  end

  def photo
    EventMailer.photo(Event.last, Photo.last, Event.last.user.email)
  end
end
