class Tender < ActiveRecord::Base
  belongs_to :country
  belongs_to :city

  validates_presence_of :name, :message => "Не задано название"
  validates_presence_of :start_date, :message => "Не указана дата начала"
  validates_presence_of :budget, :message => "Не указаy планируемый бюджет"
  validates_presence_of :description, :message => "Заполните описание"
end
