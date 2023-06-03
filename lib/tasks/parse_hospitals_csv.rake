namespace :parse do
  desc 'Parse hospitals CSV file'
  task hospitals_csv: :environment do
    Hospital.parse_csv
  end
end