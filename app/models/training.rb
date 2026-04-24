class Training < ApplicationRecord
  belongs_to :user
  belongs_to :target

  validates :theme, presence: true
  validates :explanation, presence: true, length: { minimum: 10 }
  validates :target_id, presence: true

  validate :custom_target_if_needed

  def display_target
    target.name == "その他" ? custom_target : target.name
  end

  private

  def custom_target_if_needed
    if target&.name == "その他" && custom_target.blank?
      errors.add(:custom_target, "を入力してください")
    end
  end
end
