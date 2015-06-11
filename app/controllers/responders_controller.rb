class RespondersController < ApplicationController

  def create
    begin
      @responder = Responder.new(responder_params)
      respond_to do |format|
        if @responder.save
          format.html
          format.json { render json: { 'responder' => @responder }, status: 201 }
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

  def index
    if params[:show] == 'capacity'

    end

    @responders = Responder.all
    respond_to do |format|
      format.html
      format.json { render json:
        { 'responders' =>  @responders } }
    end
  end

  def show
    @responder = Responder.find_by(name: params[:name])
    respond_to do |format|
      format.html
      format.json { render json:
        { 'responder' => {'on_duty' => @responder.on_duty } }, status: 200 }
    end
  end

  def update
    begin
      responder_update_params
      @responder = Responder.find_by(name: params[:name])
      # puts @responder
      respond_to do |format|
        if @responder.update_attribute(:on_duty, true)
          format.html
          format.json { render json:
            { 'responder' => {'on_duty' => @responder.on_duty } }, status: 201 }
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

  def destroy
  end

private

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
