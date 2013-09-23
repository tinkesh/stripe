class SubscriptionsController < ApplicationController

  def index
  @stripe_publishable = STRIPE_PUBLIC_KEY
  end

def create

  #currency = params[:currency]
  if !params[:yearly_subscription].blank?
    subscription = params[:yearly_subscription].to_i
  elsif !params[:monthly_subscription].blank?
    subscription = params[:monthly_subscription].to_i
  else
    subscription = 1
  end

  if !params[:coupon].blank?
    customer = Stripe::Customer.create(description: "Customer for #{params[:stripeToken]}", card: params[:stripeToken], plan: subscription, coupon: params[:coupon])
  else
    customer = Stripe::Customer.create(description: "Customer for #{params[:stripeToken]}", card: params[:stripeToken], plan: subscription)
  end
 @response = customer
 render :response 
end

end
