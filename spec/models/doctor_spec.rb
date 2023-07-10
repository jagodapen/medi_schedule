require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it { should have_many(:appointments) }

  it { should validate_uniqueness_of(:last_name).scoped_to(:first_name, :faculty) }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
