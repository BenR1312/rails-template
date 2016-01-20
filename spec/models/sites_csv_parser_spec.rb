require 'rails_helper'

RSpec.describe SitesCsvParser do

  describe '#initialize' do
    subject(:csv_parser) { SitesCsvParser.new(csv_file) }

    let(:csv_file) do
      Tempfile.new("csv").tap do |file|
        file.write(csv_content)
        file.rewind
      end
      # file ||= Tempfile.new("csv")
      # file.write(csv_content)
      # file.rewind
    end

    context "with valid data" do

      let!(:victoria) { FactoryGirl.create(:state, abbreviation: "VIC") }
      let(:csv_content) do
  <<-EOF
name,rural,line_1,line_2,city,state,post_code
"Hell",true,"1 Satan Street","Unit 666","Melbourne","VIC",2006
EOF
      end

      context "and site doesn't already exist" do
        it "can create a new Site from the given data" do
          expect { subject }.to change { Site.count }.by(1)

          site = Site.last
          expect(site.name).to eq("Hell")
          expect(site.rural).to eq(true)
          expect(site.address.line_1).to eq("1 Satan Street")
          expect(site.address.line_2).to eq("Unit 666")          
          expect(site.address.city).to eq("Melbourne")
          expect(site.address.state).to eq(victoria)
          expect(site.address.post_code).to eq("2006")
        end

        it "adds valid sites to @valid_sites" do
          valid_site = csv_parser.valid_sites.first

          expect(valid_site).to be_present
          expect(valid_site).to be_kind_of(Site)
          expect(valid_site).to be_valid
        end
      end

      context "the site already exists" do
        let!(:site) { FactoryGirl.create(:site, name: "Hell") }

        it "can't create a site with the same name" do
          expect { subject }.not_to change { Site.count }
        end

        it "displays a message for the site that already exists", :focus do
          already_imported_sites = csv_parser.already_imported_sites.first

          expect(already_imported_sites).to be_present
          expect(already_imported_sites).to be_kind_of(Site)
          expect(already_imported_sites).to be_persisted
        end
      end
    end

    context "site data is invalid" do
      let(:csv_content) do
  <<-EOF
name,rural,line_1,line_2,city,state,post_code
"Hell",,"1 Satan Street","Unit 666","Melbourne","VIC",2006
EOF
      end
      it "cant create a site with invalid site data" do
        expect { subject }.not_to change { Site.count }
      end
      it "adds invalid site to @invalid_sites" do
        invalid_site = csv_parser.invalid_sites.first

        expect(invalid_site).to be_present
        expect(invalid_site).to be_kind_of(Site)
        expect(invalid_site).to be_invalid
      end
    end

    context "address data is invalid" do
      let(:csv_content) do
  <<-EOF
name,rural,line_1,line_2,city,state,post_code
"Hell",true,,"Unit 666","Melbourne","VIC",2006
EOF
      end
      it "cant create a site with invalid address data" do
        expect { subject }.not_to change { Site.count }
      end
      it "adds invalid site to @invalid_sites" do
        invalid_site = csv_parser.invalid_sites.first

        expect(invalid_site).to be_present
        expect(invalid_site).to be_kind_of(Site)
        expect(invalid_site).to be_invalid
      end
    end  

  end
end

