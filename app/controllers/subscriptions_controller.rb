class SubscriptionsController < ApplicationController

  def index
  @stripe_publishable = STRIPE_PUBLIC_KEY
  end

def create

 if params[:recurring] == "1"

	  if !params[:yearly_subscription].blank?
	    subscription = params[:yearly_subscription].to_i
	  elsif !params[:monthly_subscription].blank?
	    subscription = params[:monthly_subscription].to_i
	  else
	    subscription = 1
	  end
          begin
	  if !params[:coupon].blank?
	    @response = Stripe::Customer.create(description: "Customer for #{params[:stripeToken]}", card: params[:stripeToken], plan: subscription, coupon: params[:coupon])
	  else
	    @response = Stripe::Customer.create(description: "Customer for #{params[:stripeToken]}", card: params[:stripeToken], plan: subscription)
	  end

	  rescue Stripe::InvalidRequestError => e
	  raise e
	  end


 else

	# Create the charge on Stripe's servers - this will charge the user's card
	begin
	  @response = Stripe::Charge.create(
	    :amount => params[:amount].to_i,
	    :currency => params[:currency],
	    :card => params[:stripeToken],
	    :description => params[:payoff_description]
	  )
	rescue Stripe::CardError => e
	  raise e
	end
 end

 render :response 
end

end
