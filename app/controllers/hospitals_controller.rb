class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[ show edit update destroy ]

  # GET /hospitals or /hospitals.json
  def index
    @hospitals = HospitalQuery.new(Hospital.all, params).call.page(params[:page]).per(10)
  end

  # GET /hospitals/1 or /hospitals/1.json
  def show
    @patients = PatientQuery.new(@hospital.patients, params).call.page(params[:page]).per(10)
  end

  # GET /hospitals/new
  def new
    @hospital = Hospital.new
  end

  # GET /hospitals/1/edit
  def edit
  end

  def root_page
  end

  def download_csv
    @hospitals = Hospital.includes(:patients)

    respond_to do |format|
      format.csv do
        csv_data = Hospital.to_csv
        send_data csv_data, filename: 'hospitals_and_patients.csv', type: 'text/csv'
      end
    end
  end


  def download_pdf
    @hospitals = Hospital.includes(:patients)

    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new

        @hospitals.each do |hospital|
          pdf.text "Hospital: #{hospital.name}"
          pdf.text "Address: #{hospital.address}"
          pdf.text "Creation Date: #{hospital.creation_date}"

          hospital.patients.each do |patient|
            pdf.text "Patient: #{patient.full_name}"
            pdf.text "Date of Birth: #{patient.date_of_birth}"
            pdf.move_down 10
          end

          pdf.start_new_page # Start a new page for each hospital
        end

        send_data pdf.render, filename: 'hospitals_and_patients.pdf', type: 'application/pdf', disposition: 'attachment'
      end
    end
  end


  # POST /hospitals or /hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)

    respond_to do |format|
      if @hospital.save
        format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully created." }
        format.json { render :show, status: :created, location: @hospital }
      else
        format.html { render :new }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospitals/1 or /hospitals/1.json
  def update
    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully updated." }
        format.json { render :show, status: :ok, location: @hospital }
      else
        format.html { render :edit }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitals/1 or /hospitals/1.json
  def destroy
    @hospital.destroy

    respond_to do |format|
      format.html { redirect_to hospitals_url, notice: "Hospital was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hospital_params
      params.require(:hospital).permit(:name, :address, :creation_date)
    end
end
