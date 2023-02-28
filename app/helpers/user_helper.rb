# frozen_string_literal: true

module UserHelper
  def user_has_free_trial?(user)
    user.has_free_trial?
  end

  def show_user_block_btn?(target_user)
    is_current_user_admin = current_user.authorization_tier == 'admin'
    target_user.authorization_tier == 'manager' && is_current_user_admin
  end

  def show_end_trial_btn?(target_user)
    target_user.has_free_trial? && target_user.authorization_tier == 'manager'
  end

  def white_listed?(user)
    user.white_listed?
  end

  def random_message
    messages = [
      'When you have a dream, you\'ve got to grab it and never let go.',
      'Nothing is impossible. The word itself says \'I\'m possible!\'',
      'There is nothing impossible to they who will try.',
      'The bad news is time flies. The good news is you\'re the pilot.',
      'Life has got all those twists and turns. You\'ve got to hold on tight and off you go.',
      'Keep your face always toward the sunshine, and shadows will fall behind you.'
    ]
    messages[rand(0...messages.count)]
  end

  def random_phrase_btn_text
    if cookies[:random_message_active]
      'Deactivate board quotes'
    else
      'Activate board quotes'
    end
  end

  def invitation_new_page_header
    { title: 'Set your password',
      text: 'Be part of one to the greatest task management tools',
      config: false }
  end

  def show_notification_options(target_user)
    target_user.authorization_tier == 'manager'
  end

  def notification_board_create_btn_text(target_user)
    return 'Disable board creation emails' if target_user.board_create_notification
    'Enable board creation emails'
  end

  def notification_board_update_btn_text(target_user)
    return 'Disable board update emails' if target_user.board_update_notification
    'Enable board update emails'
  end

  def notification_board_delete_btn_text(target_user)
    return 'Disable board deletion emails' if target_user.board_delete_notification
    'Enable board deletion emails'
  end
end
