require 'rails_helper'

RSpec.describe CompaniesController do
  let(:company) { FactoryGirl.create :company }

  describe 'GET show' do
    subject { get :show, params }
    let(:params) { { id: company.id} }
    it { should render_template(:show) }
  end

end
