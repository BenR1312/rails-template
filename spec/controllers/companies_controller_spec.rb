require 'rails_helper'

RSpec.describe CompaniesController do

  describe 'GET show' do
    subject { get :show, id: company.id }
    it { should render_template(:show) }
  end

end
