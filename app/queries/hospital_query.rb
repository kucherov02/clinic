class HospitalQuery
  attr_reader :relation, :params

  def initialize(relation = Hospital.all, params = {})
    @relation = relation
    @params = params
  end

  def call
    search_hospitals
    sort_hospitals
    relation
  end

  private

  def search_hospitals
    if params[:query].present?
      @relation = @relation.where('name LIKE ?', "%#{params[:query]}%")
    end
  end

  def sort_hospitals
    if params[:sort] == 'departments'
      @relation = @relation.left_joins(:departments)
                           .group(:id)
                           .order("COUNT(departments.id) #{params[:direction] || 'ASC'}")
    elsif params[:sort] == 'doctors'
      @relation = @relation.joins(departments: :doctors)
                           .group(:id)
                           .order("COUNT(doctors.id) #{params[:direction] || 'ASC'}")
    elsif params[:sort] == 'name'
      @relation = @relation.order("name #{params[:direction] || 'ASC'}")
    end
  end
end
