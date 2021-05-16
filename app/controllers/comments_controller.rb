class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:update, :edit, :destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if check_captcha(@new_comment) && @new_comment.save
      notify_subscribers(@event, @new_comment)
      redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
      render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  def update
    if current_user_can_edit?(@comment) && @comment.update(comment_params)
      redirect_to @event, notice: I18n.t('controllers.comments.updated')
    else
      render :edit
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.comments.destroyed') }

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {alert: I18n.t('controllers.comments.error')}
    end

    redirect_to @event, message
  end

  def edit; end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(event, comment)
    # Собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся и автора
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq - [comment.user&.email]

    # По адресам из этого массива делаем рассылку
    # Как и в подписках, берём EventMailer и его метод comment с параметрами
    # И отсылаем в том же потоке
    all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_now
    end
  end

  def check_captcha(model)
    current_user.present? || verify_recaptcha(model: model)
  end
end
