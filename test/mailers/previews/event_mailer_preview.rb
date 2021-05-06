class EventMailerPreview < ActionMailer::Preview
  def photo
    EventMailer.photo(Event.last, Photo.last, Event.last.user.email)
  end
end
