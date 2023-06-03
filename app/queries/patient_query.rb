class PatientQuery
  attr_reader :relation, :params

  def initialize(relation = Patient.all, params = {})
    @relation = relation.includes(:patient_card, doctor_patients: :doctor)  # to optimize performance
    @params = params
  end

  def call
    search_patients
    sort_patients
    relation
  end

  private

  def search_patients
    if params[:query].present?
      @relation = @relation.where('full_name LIKE ?', "%#{params[:query]}%")
    end

    if params[:card_number].present?
      @relation = @relation.joins(:patient_card).where('patient_cards.card_number LIKE ?', "%#{params[:card_number]}%")
    end
  end

  def sort_patients
    if params[:sort] == 'full_name'
      @relation = @relation.order("full_name #{params[:direction] || 'ASC'}")
    elsif params[:sort] == 'card_number'
      @relation = @relation.joins(:patient_card).order("patient_cards.card_number #{params[:direction] || 'ASC'}")
    elsif params[:sort] == 'age'
      @relation = @relation.order("date_of_birth #{params[:direction] == 'desc' ? 'ASC' : 'DESC'}")  # to sort by age, we sort by date of birth
    end
  end
end
