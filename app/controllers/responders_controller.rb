class RespondersController < ApplicationController

  def create
    begin
      params = responder_params
      @responder = Responder.new()
      respond_to do |format|
        if @responder.save
          puts "OK"
          format.html
          format.json { render json: @responder.to_json, status: 201 }
        else
          puts "NOT OK"
          format.html
          format.json { render json: @responder.to_json, status: 422 }
        end
      end
    rescue Exception => e
      respond_to do |format|
        format.html
        format.json { render json: { 'message' => e.message }, status: 422 }
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
