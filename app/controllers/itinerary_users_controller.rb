class ItineraryUsersController < ApplicationController

  def create
    itinerary_id = params["itinerary_id"]
    user_id = current_user.id

    @itinerary = Itinerary.find(itinerary_id)

    @itinerary.increase_spots_sold
    @itinerary_user = ItineraryUser.new(itinerary_id: itinerary_id, user_id: user_id)

    if @itinerary.valid? && @itinerary_user.valid?
      @itinerary.save && @itinerary_user.save
      flash[:notice] = "Booking successful!"
      redirect_path = itinerary_user_path(@itinerary_user.id)
    else
      flash[:notice] = "Booking unsuccessful. #{@itinerary.errors.full_messages} #{@itinerary_user.errors.full_messages}"
      redirect_path = itinerary_path(@itinerary.id)
    end

    respond_to do |format|
      format.html { redirect_to redirect_path }
      format.json { render json: @itinerary_user }
    end
  end

  def show
    itinerary_user_id = params["id"]
    @itinerary_user = ItineraryUser.where(id: itinerary_user_id).limit(1).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @itinerary_user }
    end
  end
end
