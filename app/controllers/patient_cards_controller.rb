class PatientCardsController < ApplicationController
  before_action :set_patient_card, only: %i[ show edit update destroy ]

  # GET /patient_cards or /patient_cards.json
  def index
    @patient_cards = PatientCard.all
  end

  # GET /patient_cards/1 or /patient_cards/1.json
  def show
  end

  # GET /patient_cards/new
  def new
    @patient_card = PatientCard.new
  end

  # GET /patient_cards/1/edit
  def edit
  end

  # POST /patient_cards or /patient_cards.json
  def create
    @patient_card = PatientCard.new(patient_card_params)

    respond_to do |format|
      if @patient_card.save
        format.html { redirect_to patient_card_url(@patient_card), notice: "Patient card was successfully created." }
        format.json { render :show, status: :created, location: @patient_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patient_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_cards/1 or /patient_cards/1.json
  def update
    respond_to do |format|
      if @patient_card.update(patient_card_params)
        format.html { redirect_to patient_card_url(@patient_card), notice: "Patient card was successfully updated." }
        format.json { render :show, status: :ok, location: @patient_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_cards/1 or /patient_cards/1.json
  def destroy
    @patient_card.destroy

    respond_to do |format|
      format.html { redirect_to patient_cards_url, notice: "Patient card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_card
      @patient_card = PatientCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_card_params
      params.require(:patient_card).permit(:card_number)
    end
end
