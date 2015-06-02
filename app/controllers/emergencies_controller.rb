class EmergenciesController < ApplicationController
  def create
    begin
      @emergency = Emergency.new(emergency_params)
      respond_to do |format|
        if @emergency.save
          format.html
          format.json { render json:
            { 'emergency' => {'code' => @emergency.code, 'fire_severity' => @emergency.fire_severity, 'police_severity' => @emergency.police_severity, 'medical_severity' => @emergency.medical_severity } }, status: 201 }
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

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity,:medical_severity)
  end

end
