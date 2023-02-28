# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :block_access_to_admin
  authorize_persona class_name: 'User'
  before_action :validate_is_manager
  before_action :validate_should_user_pay
  skip_before_action :block_no_paid_plans_users
  grant(
    manager: :all
  )

  def new; end

  def create
    customer_id = current_user.stripe_customer_id_or_create
    card_token = tokenizate_card

    Stripe::Charge.create({
                            amount: current_user.plan.price_cents,
                            currency: current_user.plan.price_currency,
                            source: card_token,
                            description: "Charge for usign #{current_user.plan.title}"
                          })

    current_user.remove_pay_block

    flash[:notice] = 'The payment was successfull'
    redirect_to root_path
  rescue StandardError => e
    flash[:alert] = 'There was an error, try again'
    redirect_back(fallback_location: root_path)
  end

  private

  def tokenizate_card
    token = Stripe::Token.create({
                                   card: {
                                     number: params[:card_number],
                                     exp_month: params['expiration_date(2i)'],
                                     exp_year: params['expiration_date(1i)'],
                                     cvc: params[:cvc]
                                   }
                                 })
  end

  def validate_is_manager
    unless current_user.authorization_tier == 'manager'
      flash[:alert] = 'You can not access this section'
      redirect_back(fallback_location: root_path)
    end
  end

  def validate_should_user_pay
    unless current_user.user_has_plan? && current_user.pay_block
      flash[:alert] = 'You do not have a plan to pay or you already payed'
      redirect_back(fallback_location: root_path)
    end
  end
end
