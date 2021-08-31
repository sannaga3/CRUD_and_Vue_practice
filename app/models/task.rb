class Task < ApplicationRecord
  validates :title, presence: true
  # before_validation: :set_params

  # def set_params
  #   self.id=
  # end
end
