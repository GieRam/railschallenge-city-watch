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
    @responders = Responder.all
    if params[:show] == 'capacity'
      responders_capacity(@responders)
    else
      respond_to do |format|
        format.html
        format.json { render json:
          { 'responders' =>  @responders } }
      end
    end
  end

  def show
    @responder = Responder.find_by(name: params[:name])
    if @responder.present?
      respond_to do |format|
        format.html
        format.json { render json:
          { 'responder' => @responder }, status: 200 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: {}, status: 404 }
      end
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

  def responders_capacity(responders)
    @capacity_all_by_type = responders.capacity_all_by_type
    @capacity_all_by_available = responders.capacity_all_by_type_available
    @capacity_all_by_on_duty = responders.capacity_all_by_type_on_duty
    @capacity_all_by_on_available_on_duty = responders.capacity_all_by_type_on_duty_available
    @capacity = {}
    @capacity_all_by_type.keys.each do |key|
      @capacity_all_by_type.count.times do
        @capacity[key] = [
          @capacity_all_by_type[key],
          @capacity_all_by_available[key],
          @capacity_all_by_on_duty[key],
          @capacity_all_by_on_available_on_duty[key]
        ]
      end
    end
    respond_to do |format|
      format.html
      format.json { render json:
        { 'capacity' =>  @capacity } }
    end
  end
end
