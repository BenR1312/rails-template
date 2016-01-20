class SitesCsvParser

	require 'csv'

  # CSV.foreach(file, :headers => true) do |row|
  #   Site.create!(row.to_hash)
  # end

  attr_reader :csv_file
  attr_reader :invalid_sites
  attr_reader :valid_sites

  # csv_parser = SitesCsvParser.new(csv_file)
  # csv_parser.successful_sites       # [site_1, site2]
  # csv_parser.invalid_sites          # [site_3, site4]
  # csv_parser.already_imported_sites # []
  def initialize(csv_file)
    @csv_file = csv_file

    @invalid_sites = []

    @valid_sites = []

    parse_csv_file
  end

protected

  def parse_csv_file
    CSV.foreach(csv_file, headers: true) do |row|

      row_hash = row.to_hash.with_indifferent_access
      if Site.exists?(name: row_hash[:name])
        # Show message
      else
        address = Address.new(row_hash.slice(:line_1, :line_2, :city, :post_code))
        address.state = get_state(row_hash[:state])
        address.save

        site = Site.create(row_hash.slice(:name, :rural).merge(address: address))

        if site.invalid?
          @invalid_sites << site
        else
          @valid_sites << site
        end

        # @invalid_sites << an_invalid_site
      end

      # USING accepts_nested_attributes_for

      # row_hash = row.to_hash.with_indifferent_access
      # address_attributes = row_hash.slice(:line_1, :line_2, :city, :state, :post_code)
      # site_attributes    = row_hash.slice(:name, :rural).merge(address_attributes: address_attributes)
      # Site.create!(site_attributes)
    end    
  end

private

  def get_state(abbreviation)
    State.find_by abbreviation: abbreviation
  end

end
