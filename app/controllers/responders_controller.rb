class RespondersController < ApplicationController
  
  def create
  	@responder = Responder.new(responder_params)
	  respond_to do |format|
	  	if @responder.save
	  		format.html
	  		format.json { render json: @responder.to_json, status: 201 }
	  	end
	  end
  end

  def update
  	
  end

  def destroy
  end
	
private

	def responder_params
		params.require(:responder).permit(:type, :name, :capacity, :on_duty, :emergency_code)
	end

end
