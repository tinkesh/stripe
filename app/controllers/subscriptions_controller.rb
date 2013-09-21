class SubscriptionsController < ApplicationController

  def index
  @stripe_publishable = STRIPE_PUBLIC_KEY
  end

def create
  customer = Stripe::Customer.create(description: "Customer for #{params[:stripeToken]}", card: params[:stripeToken], plan: params[:subscription].to_i)
 @response = customer
 render :response 
end

end
