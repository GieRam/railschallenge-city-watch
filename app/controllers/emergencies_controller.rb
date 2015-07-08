class EmergenciesController < ApplicationController

  def show
    @emergency = Emergency.find_by(code: params[:code])
    if @emergency.present?
      respond_to do |format|
        format.html
        format.json { render json:
          { 'emergency' => @emergency }, status: 200 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: {}, status: 404 }
      end
    end
  end

  def index
    @emergencies = Emergency.all
    respond_to do |format|
      format.html
      format.json { render json:
        { 'emergencies' =>  @emergencies } }
    end
  end

  def create
    begin
      @emergency = Emergency.new(emergency_params)
      respond_to do |format|
        if @emergency.save
          format.html
          format.json { render json: { 'emergency' => @emergency }, status: 201 }
        else
          format.html
          format.json { render json: { 'message' => @emergency.errors }, status: 422 }
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
    begin
      @emergency = Emergency.find_by(code: params[:code])
      respond_to do |format|
        if @emergency.update!(emergency_update_params)
          format.html
          format.json { render json: { 'emergency' => @emergency }, status: 201 }
        else
          format.html
          format.json { render json: { 'message' => @emergency.errors }, status: 422 }
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

  def emergency_update_params
    params.require(:emergency).permit(:fire_severity, :police_severity,:medical_severity, :resolved_at)
  end

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity,:medical_severity, :resolved_at)
  end

end
