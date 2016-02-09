require 'rails_helper'

RSpec.describe SupportRequest, type: :model do
  describe 'validations' do
    it "doesn't allow creating a request with no name" do
      r = SupportRequest.new
      r.valid?
      expect(r.errors).to have_key(:name)
    end
    it "doesn't allow creating a request with no email" do
      r = SupportRequest.new
      r.valid?
      expect(r.errors).to have_key(:email)
    end
  end
end
