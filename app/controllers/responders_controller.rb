class RespondersController < ApplicationController

  def create
    begin
      @responder = Responder.new(responder_params)
      respond_to do |format|
        if @responder.save
          format.html
          format.json { render json:
            { 'responder' => {'type' => @responder.type, 'emergency_code' => @responder.emergency_code, 'name' => @responder.name, 'capacity' => @responder.capacity, 'on_duty' => @responder.on_duty } }, status: 201 }
        else
          format.html
          format.json { render json: { 'message' => @responder.errors }, status: 422 }
        end
      end
    rescue Exception => e
      respond_to do |format|
        format.html
        format.json { render json: { 'message' => e.message }, status: 422 }
      end
    end
  end

private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
