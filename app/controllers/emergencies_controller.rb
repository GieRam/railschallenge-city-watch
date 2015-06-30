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
    @emergency = Emergency.find(params[:code])
  end

private

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity,:medical_severity)
  end

end
